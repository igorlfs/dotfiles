return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        highlight_overrides = {
            mocha = function(mocha)
                return {
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
            neotest = true,
            notify = true,
            noice = true,
            octo = true,
            ufo = false,
            mini = true,
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
