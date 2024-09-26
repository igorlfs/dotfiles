return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/noice.nvim", "mfussenegger/nvim-dap" },
    event = "VeryLazy",
    config = function()
        local noice = require("noice.api")

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
                lualine_b = { { "filename", path = 1 } },
                lualine_c = {},
                lualine_x = {
                    {
                        noice.status.mode.get_hl,
                        cond = noice.status.mode.has,
                    },
                    "kulala",
                    "diff",
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
