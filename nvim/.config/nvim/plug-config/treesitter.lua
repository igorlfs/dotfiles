require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp"},
  highlight = {
    enable = true,
  },
  indent = { 
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    navigation = {
      enable = true,
      keymaps = {
        goto_next_usage = "<a-k>",
        goto_previous_usage = "<a-l>",
      },
    },
  },
}
