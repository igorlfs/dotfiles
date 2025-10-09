local M = {}

-- Inspired by <https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/statusline.lua>

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

local api = vim.api

api.nvim_set_hl(0, "StatusLinePathDir", { link = "Visual" })
api.nvim_set_hl(0, "StatusLineVimSelection", { link = "TermCursor" })
api.nvim_set_hl(0, "StatusLineVimSpell", { link = "Function" })
-- not using DapBreakpoint to make it more distinguishable when there are errors in diagnostics
api.nvim_set_hl(0, "StatusLineDapIcon", { link = "Title" })
api.nvim_set_hl(0, "StatusLineAutoFormat", { link = "DiagnosticWarn" })
api.nvim_set_hl(0, "StatusLinePluginKulala", { link = "TermCursor" })

local get_mode_hl = function()
    local mode = api.nvim_get_mode().mode
    local mini_mode = "MiniStatuslineMode"

    -- These groups are enabled because catppuccin detects mini.ai and enables all of mini's hl groups

    if vim.startswith(mode, "i") or mode == "t" then
        return mini_mode .. "Insert"
    elseif vim.startswith(mode, "n") then
        return mini_mode .. "Normal"
    elseif vim.startswith(mode, "R") then
        return mini_mode .. "Replace"
    elseif vim.startswith(mode:lower(), "v") then
        return mini_mode .. "Visual"
    elseif mode == "c" then
        return mini_mode .. "Command"
    else
        return mini_mode .. "Other"
    end
end

local vim_diagnostic_config = vim.diagnostic.config() or {}
local signs = vim_diagnostic_config.signs or {}
if type(signs) == "function" then
    signs = signs(0, 0)
end

local vim_diagnostic_icons = (type(signs) == "table" and signs.text) or {}

local severity_to_string = { "Error", "Warn", "Info", "Hint" }

M.vim_diagnostics = function()
    if vim.bo.filetype == "lazy" then
        return ""
    end

    local counts = vim.iter(vim.diagnostic.get(0)):fold(
        { 0, 0, 0, 0 },
        ---@param acc integer[]
        ---@param diagnostic vim.Diagnostic
        function(acc, diagnostic)
            acc[diagnostic.severity] = acc[diagnostic.severity] + 1
            return acc
        end
    )

    local severity = 0
    local parts = vim.iter(counts)
        :map(
            ---@param count integer
            function(count)
                -- This works because the severity is implicitly mapped as E:1,W:2,I:3,H:4
                severity = severity + 1

                if count == 0 then
                    return nil
                end

                local icon = vim_diagnostic_icons[severity]

                local hl = "Diagnostic" .. severity_to_string[severity]

                return string.format("%%#%s#%s%%* %d ", hl, icon, count)
            end
        )
        :totable()

    local result = table.concat(parts)

    if result == "" then
        return ""
    end

    return string.format(" %s", result)
end

M.git_branch = function()
    ---@type string?
    local result = vim.b.gitsigns_head or vim.g.gitsigns_head

    if not result or result == "" then
        return ""
    end

    local hl = get_mode_hl()

    return string.format("%%#%s#  %s %%*", hl, result)
end

M.git_hunks = function()
    local hunks = require("gitsigns").get_hunks()

    ---@type table<Gitsigns.Hunk.Type, number>
    local file_changes = vim.iter(hunks or {}):fold(
        { add = 0, change = 0, delete = 0 },
        ---@param acc table<Gitsigns.Hunk.Type, number>
        ---@param hunk Gitsigns.Hunk.Hunk_Public
        function(acc, hunk)
            acc[hunk.type] = acc[hunk.type] + hunk.added.count + hunk.removed.count
            return acc
        end
    )

    local result = ""

    if file_changes["add"] > 0 then
        result = string.format("%%#%s# +%d%%*", "GitSignsAdd", file_changes["add"])
    end
    if file_changes["change"] > 0 then
        result = result
            .. string.format("%%#%s# ~%d%%*", "GitSignsChange", file_changes["change"] / 2)
    end
    if file_changes["delete"] > 0 then
        result = result .. string.format("%%#%s# -%d%%*", "GitSignsDelete", file_changes["delete"])
    end

    if result == "" then
        return ""
    end

    return string.format("%s ", result)
end

M.dap_session = function()
    if not package.loaded["dap"] then
        return ""
    end

    local status = require("dap").status()

    if status ~= "" then
        status = string.format(" %s ", status)
    end

    local result = require("dap").session() and " " or ""

    if result == "" then
        return ""
    end

    return string.format("%s%%#%s#%s %%*", status, "StatusLineDapIcon", result)
end

M.vim_session = function()
    local result = require("possession.session").get_session_name() or ""

    if result == "" then
        return ""
    end

    local hl = get_mode_hl()

    return string.format("%%#%s# %s %%*", hl, result)
end

M.vim_macro = function()
    ---@type string
    local register = vim.fn.reg_recording()
    if register == "" then
        return ""
    end

    return string.format(" @%s ", register)
end

M.path_dir = function()
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~:.")
    local result = cwd:sub(1, 1) == "~" and cwd:sub(3) or cwd

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLinePathDir", result)
end

M.path_file = function()
    local result = vim.fn.expand("%:p:.")

    if result == "" then
        return ""
    end

    return string.format(" %s", result)
end

M.vim_spell = function()
    local result = vim.wo.spell and "󰓆 " or ""

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLineVimSpell", result)
end

M.auto_format = function()
    local result = vim.g.disable_autoformat and "󰉪 " or ""

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLineAutoFormat", result)
end

M.plugin_kulala = function()
    local env = require("kulala").get_selected_env()
    local ft = vim.bo[0].ft
    local result = (ft ~= "http" or not env) and "" or env

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLinePluginKulala", result)
end

-- Copied from Lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/searchcount.lua
M.vim_search = function()
    if vim.v.hlsearch == 0 then
        return ""
    end

    ---@type {current: number, maxcount:number, total:number}
    local result = vim.fn.searchcount()

    if next(result) == nil then
        return ""
    end

    local denominator = math.min(result.total, result.maxcount)
    return string.format(" [%d/%d] ", result.current, denominator)
end

-- Copied from Lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/selectioncount.lua
M.vim_selection = function()
    local get_selection = function()
        local mode = vim.fn.mode(true)
        local line_start, col_start = vim.fn.line("v"), vim.fn.col("v")
        local line_end, col_end = vim.fn.line("."), vim.fn.col(".")
        if mode:match("") then
            return string.format(
                "%dx%d",
                math.abs(line_start - line_end) + 1,
                math.abs(col_start - col_end) + 1
            )
        elseif mode:match("V") or line_start ~= line_end then
            return tostring(math.abs(line_start - line_end) + 1)
        elseif mode:match("v") then
            return tostring(math.abs(col_start - col_end) + 1)
        else
            return ""
        end
    end

    local result = get_selection()

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLineVimSelection", result)
end

vim.go.laststatus = 3

M.render = function()
    return table.concat({
        M.git_branch(),
        M.path_dir(),
        M.path_file(),
        "%#StatusLine#%=",
        M.vim_macro(),
        M.plugin_kulala(),
        M.vim_search(),
        M.git_hunks(),
        M.vim_spell(),
        M.auto_format(),
        M.dap_session(),
        M.vim_diagnostics(),
        M.vim_selection(),
        M.vim_session(),
    })
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M
