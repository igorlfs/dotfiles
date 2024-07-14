return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        term_colors = true,
        highlight_overrides = {
            mocha = function(mocha)
                return {
                    FloatBorder = { fg = mocha.blue, bg = mocha.mantle },
                }
            end,
        },
        integrations = {
            neotest = true,
            mason = true,
            noice = true,
            octo = true,
            diffview = true,
            ufo = false,
            navic = { enabled = true },
            telescope = {
                style = "nvchad",
            },
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}
