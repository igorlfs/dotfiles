return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        term_colors = true,
        auto_integrations = true,
    },
    init = function() vim.cmd.colorscheme("catppuccin") end,
}
