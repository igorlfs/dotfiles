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
            mason = true,
            noice = true,
            octo = true,
            diffview = true,
            telescope = {
                style = "nvchad",
            },
        },
    },
}
