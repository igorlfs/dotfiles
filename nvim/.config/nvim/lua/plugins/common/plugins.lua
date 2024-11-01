return {
    ------ Editing
    -- Pairs
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = { ignored_next_char = "" } },
    -- Surround
    { "kylechui/nvim-surround", event = "VeryLazy", config = true },
    -- Indentation
    { "nmac427/guess-indent.nvim", config = true },
    -- Tags
    { "windwp/nvim-ts-autotag", event = "InsertEnter", config = true },
    -- (f-)Strings
    { "axelvc/template-string.nvim", event = "InsertEnter", config = true },
}
