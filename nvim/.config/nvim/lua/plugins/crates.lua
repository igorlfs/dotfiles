return {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        popup = {
            border = "rounded",
        },
        src = {
            cmp = {
                enabled = true,
            },
        },
    },
}
