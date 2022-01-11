require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "comment", "make"},
  highlight = {
    enable = true,
  },
  indent = { 
    enable = true,
  },
}
