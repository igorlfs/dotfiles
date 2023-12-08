return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "haydenmeade/neotest-jest",
        "rcasia/neotest-java",
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
        { "<A-n>", "<CMD>Neotest summary toggle<CR>", desc = "Toggle Neotest" },
        { "<leader>tn", "<CMD>Neotest run<CR>", desc = "[T]est [N]earest" },
        { "<leader>ts", "<CMD>Neotest stop<CR>", desc = "[T]est [S]top" },
        { "<leader>tf", "<CMD>Neotest run file<CR>", desc = "[T]est [F]ile" },
        {
            "<leader>td",
            function() require("neotest").run.run({ strategy = "dap" }) end,
            desc = "[T]est [D]ebug",
        },
    },
    cmd = "Neotest",
}
