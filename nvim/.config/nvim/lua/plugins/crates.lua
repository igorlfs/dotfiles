return {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        popup = {
            border = "rounded",
        },
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
        },
    },
}
