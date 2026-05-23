local util = require("igorlfs.util")

if not pcall(require, "dap-view") then
    return
end

local api = vim.api

local adapter_to_filetypes = {
    debugpy = { "python" },
    ["pwa-node"] = { "javascript", "typescript" },
    emmylua = { "lua" },
}

require("dap-view").setup({
    follow_tab = function(adapter)
        local cur_tab_wins = api.nvim_tabpage_list_wins(0)

        local adapter_fitetypes = adapter_to_filetypes[adapter]

        return vim.iter(cur_tab_wins or {}):any(
            ---@param win integer
            function(win)
                local buf = api.nvim_win_get_buf(win)
                return vim.tbl_contains(adapter_fitetypes or {}, vim.bo[buf].filetype)
            end
        )
    end,
    virtual_text = {
        format = function(variable)
            return " " .. (variable.value:gsub("\n+", ""))
        end,
        position = "eol",
    },
    winbar = {
        show_keymap_hints = false,
        sections = {
            "watches",
            "scopes",
            "exceptions",
            "repl",
            "sessions",
            "breakpoints",
            "threads",
            "console",
        },
        default_section = "threads",
    },
    switchbuf = "usetab,newtab",
    keymaps = {
        threads = {
            filter = "s",
            toggle_subtle_frames = "i",
        },
        watches = {
            edit_expression = "x",
        },
    },
    windows = {
        size = function(pos)
            return pos == "below" and 0.3 or 0.45
        end,
        position = function(prev)
            local wins = api.nvim_tabpage_list_wins(0)

            if
                vim.iter(wins):find(function(win)
                    return vim.w[win].dapview_win_term
                end)
            then
                return prev
            end

            ---@param layout vim.fn.winlayout.ret
            ---@return boolean
            local function layout_has_vsplit(layout)
                local type = layout[1]
                if type == "leaf" then
                    return false
                elseif type == "row" then
                    return true
                else -- "col"
                    ---@cast layout[2] (vim.fn.winlayout.branch|vim.fn.winlayout.leaf)[]
                    for _, child in ipairs(layout[2]) do
                        if layout_has_vsplit(child) then
                            return true
                        end
                    end
                    return false
                end
            end

            local vsplit = layout_has_vsplit(vim.fn.winlayout())

            return vsplit and "below" or "right"
        end,
        terminal = {
            hide = { "pwa-node", "pwa-chrome" },
            size = 0.5,
            position = function(pos)
                return pos == "below" and "right" or "below"
            end,
        },
    },
})

util.keymap("<A-m>", "<CMD>DapViewToggle<CR>", "Toggle DAP UI")
util.keymap("<A-v>", "<CMD>DapViewVirtualTextToggle<CR>", "Toggle DAP Virtual Text")
util.keymap("<F1>", "<CMD>DapViewHover!<CR>", "DAP Hover", { "n", "x" })
