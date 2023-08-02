return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
            "haydenmeade/neotest-jest",
            "andy-bell101/neotest-java",
            "sidlatau/neotest-dart",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        args = { "-v" }, -- get more diff
                    }),
                    require("neotest-rust"),
                    require("neotest-jest"),
                    require("neotest-java"),
                    require("neotest-dart"),
                },
                output = {
                    -- disable pop-up with failing test info (prefer virtual text)
                    open_on_run = false,
                },
                quickfix = {
                    enabled = false,
                },
            })
        end,
        keys = {
            { "<leader>ts", "<CMD>Neotest summary toggle<CR>", desc = "Toggle Test Summary" },
            { "<leader>tn", "<CMD>Neotest run<CR>", desc = "[T]est [N]earest" },
            { "<leader>tf", "<CMD>Neotest run file<CR>", desc = "[T]est [F]ile" },
            {
                "<leader>dt",
                function() require("neotest").run.run({ strategy = "dap" }) end,
                desc = "Debug Test",
            },
        },
        cmd = "Neotest",
    },
}
