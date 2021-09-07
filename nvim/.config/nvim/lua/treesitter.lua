require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { 
    enable = true,
  },
}
