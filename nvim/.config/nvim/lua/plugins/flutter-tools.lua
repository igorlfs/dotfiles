return {
    "akinsho/flutter-tools.nvim",
    -- We can't use `opts` here because Lazy can't figure out the order to load nvim-cmp
    -- We probably should add nvim-cmp or cmp_nvim_lsp as dependencies for this plugin
    -- Right now can't test if that would work as I don't have flutter stuff installed
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
    },
    ft = "dart",
    config = function()
        require("flutter-tools").setup({
            lsp = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            },
            debugger = {
                enabled = true,
                run_via_dap = true,
                exception_breakpoints = {},
            },
            dev_log = {
                enabled = false,
            },
        })
    end,
}
