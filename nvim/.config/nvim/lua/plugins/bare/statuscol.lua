return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    sign = {
                        name = { "Dap" },
                        namespace = { "diagnostic" },
                        maxwidth = 1,
                        colwidth = 2,
                        auto = false,
                    },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                {
                    sign = {
                        namespace = { "gitsigns" },
                        maxwidth = 1,
                        colwidth = 1,
                        auto = false,
                        wrap = true,
                        fillcharhl = "StatusColumnSeparator",
                    },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            },
            ft_ignore = {
                "NvimTree",
                "NeogitStatus",
                "NeogitPopup",
                "NeogitCommitMessage",
                "NeogitCommitView",
                "dap-repl",
            },
            bt_ignore = {
                "terminal",
            },
        })
    end,
}
