require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp"},
  highlight = {
    enable = true,
    custom_captures = {},
    },
  indent = {
    enable = true
  }
}
