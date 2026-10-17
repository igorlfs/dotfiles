local M = {}

local api = vim.api

local ns = api.nvim_create_namespace("dap-repl-highlights")

---@class replhl.Config
---@field adapters table<string,string> Maps an adapter to a treesitter language

---@type replhl.Config
M.opts = {
    adapters = {
        ["pwa-node"] = "javascript",
        ["pwa-chrome"] = "javascript",
        debugpy = "python",
        nlua = "lua",
        emmylua = "lua",
    },
}

---@type table<integer, string>
local buf_lang = {}

---@type table<integer, true>
local attached = {}

---@type table<integer, true>
local pending = {}

---Captures that don't map to a highlight group
local ignored_captures = { spell = true, nospell = true, conceal = true }

---Applies the highlights of every tree of `ltree` (and, recursively, of its injected children).
---@param buf integer
---@param row integer 0-based row of the start of `text`
---@param col integer 0-based byte column of the start of `text`
---@param text string
---@param ltree vim.treesitter.LanguageTree
---@param depth integer Injection depth, 0 for the root language
local function highlight_ltree(buf, row, col, text, ltree, depth)
    local lang = ltree:lang()
    local query = vim.treesitter.query.get(lang, "highlights")

    if query then
        for _, tree in pairs(ltree:trees()) do
            for id, node, metadata in query:iter_captures(tree:root(), text) do
                local name = query.captures[id] or "_"
                -- Captures starting with "_" are helpers for predicates, not highlights
                if not vim.startswith(name, "_") and not ignored_captures[name] then
                    local sr, sc, er, ec = node:range()
                    local capture_md = metadata[id] or {}
                    local priority = tonumber(metadata.priority or capture_md.priority) or vim.hl.priorities.treesitter
                    -- Node ranges are relative to `text`: only its first line is offset by the prompt
                    api.nvim_buf_set_extmark(buf, ns, row + sr, (sr == 0 and col or 0) + sc, {
                        end_row = row + er,
                        end_col = (er == 0 and col or 0) + ec,
                        hl_group = "@" .. name .. "." .. lang,
                        priority = priority + depth,
                        strict = false,
                    })
                end
            end
        end
    end

    for _, child in pairs(ltree:children()) do
        highlight_ltree(buf, row, col, text, child, depth + 1)
    end
end

---@param buf integer
---@param row integer 0-based
---@param col integer 0-based byte column
---@param text string
---@param lang string
local function highlight(buf, row, col, text, lang)
    local ok, parser = pcall(vim.treesitter.get_string_parser, text, lang)
    if not ok then
        return
    end
    parser:parse(true)
    highlight_ltree(buf, row, col, text, parser, 0)
end

---@param buf integer
local function refresh(buf)
    local lang = buf_lang[buf]
    if not lang or not api.nvim_buf_is_valid(buf) then
        return
    end

    local ok, mark = pcall(api.nvim_buf_get_mark, buf, ":")
    if not ok or mark[1] == 0 then
        return
    end
    local row, col = mark[1] - 1, mark[2]

    api.nvim_buf_clear_namespace(buf, ns, row, -1)

    local text = vim.fn.prompt_getinput(buf)
    if text ~= "" then
        highlight(buf, row, col, text, lang)
    end
end

---@param buf integer
local function schedule_refresh(buf)
    if pending[buf] then
        return
    end
    pending[buf] = true
    -- Extmarks can't be set from `on_lines`, and the text may still be changing
    vim.schedule(function()
        pending[buf] = nil
        refresh(buf)
    end)
end

---@param buf integer
local function ensure_attached(buf)
    if attached[buf] then
        return
    end
    attached[buf] = true
    api.nvim_buf_attach(buf, false, {
        on_lines = function()
            schedule_refresh(buf)
        end,
        on_detach = function()
            attached[buf] = nil
            buf_lang[buf] = nil
        end,
    })
end

---@param buf integer
---@param session dap.Session?
function M.attach(buf, session)
    if not session or not buf or not api.nvim_buf_is_valid(buf) then
        return
    end

    buf_lang[buf] = M.opts.adapters[session.config.type]

    ensure_attached(buf)
    refresh(buf)
end

return M
