return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        term_colors = true,
        highlight_overrides = {
            mocha = function(mocha)
                return {
                    -- See catppuccin/nvim#313
                    NormalFloat = { fg = mocha.text, bg = mocha.none },
                }
            end,
        },
        integrations = {
            neotest = true,
            mason = true,
            noice = true,
            octo = true,
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
