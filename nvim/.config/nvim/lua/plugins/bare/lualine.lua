return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                refresh = {
                    statusline = 100,
                },
            },
            sections = {
                lualine_a = { "branch" },
                lualine_b = {
                    function()
                        local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~:.")
                        return cwd:sub(1, 1) == "~" and cwd:sub(3) or cwd
                    end,
                },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = {
                    {
                        function()
                            local register = vim.fn.reg_recording() --[[@as string]]
                            return (register ~= "" and "@") .. register
                        end,
                    },
                    "kulala",
                    "diff",
                    {
                        function() return vim.wo.spell and "󰓆" or "" end,
                        color = "DapLogPoint",
                    },
                    {
                        function() return vim.g.disable_autoformat and "󰉩" or "" end,
                        color = "DapBreakpointCondition",
                    },
                    {
                        function() return require("dap").session() and " " or "" end,
                        color = "DapBreakpoint",
                    },
                },
                lualine_y = { "diagnostics", "selectioncount" },
                lualine_z = {
                    function() return require("possession.session").get_session_name() or "" end,
                },
            },
        })
    end,
}
