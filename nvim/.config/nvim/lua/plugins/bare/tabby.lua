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
                        local buftype = vim.fn.getbufvar(bufnr, "&buftype")
                        local filetype = vim.fn.getbufvar(bufnr, "&filetype") --[[@as string]]
                        local full_buf_name = vim.api.nvim_buf_get_name(bufnr)

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
                        elseif full_buf_name == "kulala://ui" then
                            return "Kulala"
                        else
                            local name = buf_name.get(bufnr)
                            if vim.bo[vim.api.nvim_win_get_buf(winid)].modified then
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
