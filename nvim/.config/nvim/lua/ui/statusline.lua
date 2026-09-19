local M = {}

-- Inspired by <https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/statusline.lua>

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

local api = vim.api
local fn = vim.fn

api.nvim_set_hl(0, "StatusLinePathDir", { link = "Visual" })
api.nvim_set_hl(0, "StatusLineVimSelection", { link = "TermCursor" })
api.nvim_set_hl(0, "StatusLineVimSpell", { link = "Function" })
-- not using DapBreakpoint to make it more distinguishable when there are errors in diagnostics
api.nvim_set_hl(0, "StatusLineDapIcon", { link = "Title" })
api.nvim_set_hl(0, "StatusLineAutoFormat", { link = "DiagnosticWarn" })
api.nvim_set_hl(0, "StatusLineBusy", { link = "Boolean" })

M.vim_diagnostics = function()
    local status = vim.diagnostic.status()

    if status == "" then
        return ""
    end

    return string.format(" %s ", status:gsub(":", " "))
end

M.git_branch = function()
    ---@type string?
    local result = vim.b.gitsigns_head or vim.g.gitsigns_head

    if not result or result == "" then
        return ""
    end

    local hl = require("ui.shared").get_mode_hl()

    return string.format("%%#%s#  %s %%*", hl, result)
end

M.git_hunks = function()
    local gitsigns_status = vim.b.gitsigns_status_dict

    if not gitsigns_status then
        return ""
    end

    local result = ""

    local gitsigns_added = gitsigns_status["added"]
    if gitsigns_added and gitsigns_added > 0 then
        result = string.format("%%#%s# +%d%%*", "GitSignsAdd", gitsigns_added)
    end

    local gitsigns_changed = gitsigns_status["changed"]
    if gitsigns_changed and gitsigns_changed > 0 then
        result = result .. string.format("%%#%s# ~%d%%*", "GitSignsChange", gitsigns_changed)
    end

    local gitsigns_removed = gitsigns_status["removed"]
    if gitsigns_removed and gitsigns_removed > 0 then
        result = result .. string.format("%%#%s# -%d%%*", "GitSignsDelete", gitsigns_removed)
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
    local result = require("restaurus").session_name()

    -- Handle special "temporary" session
    if result == nil or result == "__" then
        return ""
    end

    local hl = require("ui.shared").get_mode_hl()

    return string.format("%%#%s# %s %%*", hl, result)
end

M.vim_macro = function()
    ---@type string
    local register = fn.reg_recording()
    if register == "" then
        return ""
    end

    return string.format(" @%s ", register)
end

M.vim_busy = function()
    local busy = vim.bo.busy

    if busy == 0 then
        return ""
    end

    return string.format("%%#%s#  %%*", "StatusLineBusy")
end

M.path_dir = function()
    local cwd = fn.fnamemodify(fn.getcwd(), ":~:.")
    local result = cwd:sub(1, 1) == "~" and cwd:sub(3) or cwd

    if result == "" then
        return ""
    end

    return string.format("%%#%s# %s %%*", "StatusLinePathDir", result)
end

M.path_file = function()
    local result = fn.expand("%:p:.")

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

-- Copied from Lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/searchcount.lua
M.vim_search = function()
    if vim.v.hlsearch == 0 then
        return ""
    end

    -- In some scenarios, `searchcount` may throw an error
    local ok, result = pcall(fn.searchcount)

    if not ok or next(result) == nil then
        return ""
    end

    ---@cast result {current: number, maxcount:number, total:number}

    local denominator = math.min(result.total, result.maxcount)
    return string.format(" [%d/%d] ", result.current, denominator)
end

-- Copied from Lualine
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/selectioncount.lua
M.vim_selection = function()
    local get_selection = function()
        local mode = fn.mode(true)
        local line_start, col_start = fn.line("v"), fn.col("v")
        local line_end, col_end = fn.line("."), fn.col(".")
        if mode:match("") then
            return string.format("%dx%d", math.abs(line_start - line_end) + 1, math.abs(col_start - col_end) + 1)
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
        M.vim_search(),
        M.git_hunks(),
        M.vim_busy(),
        M.vim_spell(),
        M.auto_format(),
        M.dap_session(),
        M.vim_diagnostics(),
        M.vim_selection(),
        M.vim_session(),
    })
end

vim.o.statusline = "%!v:lua.require'ui.statusline'.render()"

return M
