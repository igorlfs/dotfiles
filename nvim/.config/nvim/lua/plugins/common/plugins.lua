return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "igorlfs/nvim-dap-repl-highlights", config = true },
        },
    },
}
