return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            { "igorlfs/nvim-dap-repl-highlights", config = true },
        },
    },
    -- Pairs
    {
        "windwp/nvim-autopairs",
        opts = { ignored_next_char = "", enable_check_bracket_line = false },
    },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", config = true },
}
