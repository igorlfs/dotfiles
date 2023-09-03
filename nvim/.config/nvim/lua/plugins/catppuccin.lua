return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        jukit_cellmarker_colors = { bg = mocha.mantle, fg = mocha.mantle },
                        jukit_textcell_bg_colors = { bg = mocha.crust },

                        -- See catppuccin/nvim#313
                        NormalFloat = { fg = mocha.text, bg = mocha.none },
                    }
                end,
            },
            integrations = {
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                ufo = true,
                neotest = true,
                notify = true,
                noice = true,
                octo = true,
                mini = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd([[colorscheme catppuccin]])
        end,
    },
}
