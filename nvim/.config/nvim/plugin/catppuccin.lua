local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("catppuccin/nvim"), name = "catppuccin" },
})

require("catppuccin").setup({
    term_colors = true,
    auto_integrations = true,
})

vim.cmd.colorscheme("catppuccin-mocha")
