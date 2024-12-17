local theme = {
    fill = "TabLineFill",
    current_tab = "TabLineSel",
    tab = "TabLine",
}

return {
    "nanozuki/tabby.nvim",
    config = function()
        local api = require("tabby.module.api")
        local buf_name = require("tabby.feature.buf_name")

        require("tabby").setup({
            option = {
                tab_name = {
                    name_fallback = function(tabid)
                        local winid = api.get_tab_current_win(tabid)
                        local bufnr = api.get_win_buf(winid)
                        local buftype = vim.fn.getbufvar(bufnr, "&buftype") --[[@as string]]
                        local filetype = vim.fn.getbufvar(bufnr, "&filetype") --[[@as string]]

                        if buftype == "terminal" then
                            return "Terminal"
                        elseif filetype == "checkhealth" then
                            return "Checkhealth"
                        elseif filetype == "NvimTree" then
                            return "NvimTree"
                        elseif filetype == "octo" then
                            return "Octo"
                        elseif filetype == "mason" then
                            return "Mason"
                        elseif filetype == "lazy" then
                            return "Lazy"
                        elseif filetype == "dap-repl" then
                            return "REPL"
                        elseif filetype == "dap-float" then
                            return "DAP"
                        elseif string.match(filetype, "Telescope") then
                            return "Telescope"
                        elseif string.match(filetype, "Neogit") then
                            return filetype
                        elseif vim.api.nvim_buf_get_name(bufnr) == "kulala://ui" then
                            return "Kulala"
                        else
                            local name = buf_name.get(winid)
                            if vim.bo[bufnr].modified then
                                return name .. " ●"
                            else
                                return name
                            end
                        end
                    end,
                },
            },
            line = function(line)
                return {
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        local number = "[" .. tab.number() .. "]"
                        return {
                            line.sep("", hl, theme.fill),
                            number,
                            tab.name(),
                            line.sep("", hl, theme.fill),
                            hl = hl,
                            margin = " ",
                        }
                    end),
                    line.spacer(),
                    hl = theme.fill,
                }
            end,
        })
    end,
}
