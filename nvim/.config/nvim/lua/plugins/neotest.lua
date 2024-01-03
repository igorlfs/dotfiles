return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "rcasia/neotest-java",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    args = { "-v" }, -- get more diff
                }),
                require("neotest-rust"),
                require("neotest-java"),
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
        { "<leader>tn", "<CMD>Neotest run<CR>", desc = "Test Nearest" },
        { "<leader>ts", "<CMD>Neotest stop<CR>", desc = "Test Stop" },
        { "<leader>tf", "<CMD>Neotest run file<CR>", desc = "Test File" },
        {
            "<leader>td",
            function() require("neotest").run.run({ strategy = "dap" }) end,
            desc = "Test Debug",
        },
    },
    cmd = "Neotest",
}
