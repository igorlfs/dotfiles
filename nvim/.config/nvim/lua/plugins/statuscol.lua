return {
    "luukvbaal/statuscol.nvim",
    event = "VimEnter",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    sign = {
                        name = {
                            "Dap",
                            "neotest",
                            "Diagnostic",
                        },
                        maxwidth = 1,
                        colwidth = 2,
                        auto = false,
                    },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
                {
                    sign = {
                        name = { "GitSigns" },
                        maxwidth = 1,
                        colwidth = 1,
                        auto = false,
                        fillcharhl = "StatusColumnSeparator",
                    },
                    click = "v:lua.ScSa",
                },
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            },
            ft_ignore = {
                "NvimTree",
                "NeogitStatus",
                "NeogitCommitMessage",
                "toggleterm",
                "dapui_scopes",
                "dapui_breakpoints",
                "dapui_stacks",
                "dapui_watches",
                "dapui_console",
                "dap-repl",
                "neotest-summary",
            },
            bt_ignore = {
                "terminal",
            },
        })
    end,
}
