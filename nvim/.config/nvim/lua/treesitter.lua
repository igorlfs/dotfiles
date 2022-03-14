require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "comment", "make", "lua", "python" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
}
