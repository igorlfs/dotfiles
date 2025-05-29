return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        lazy = false,
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- Pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { ignored_next_char = "", enable_check_bracket_line = false },
    },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
    -- (f-)Strings
    { "axelvc/template-string.nvim", event = "VeryLazy", config = true },
}
