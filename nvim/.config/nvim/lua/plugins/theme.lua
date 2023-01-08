require("catppuccin").setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    highlight_overrides = {
        mocha = function(mocha)
            return {
                -- see catppuccin/nvim#313
                NormalFloat = { fg = mocha.text, bg = mocha.none },
            }
        end,
    },
    integrations = {
        dap = {
            enabled = true,
            enable_ui = true,
        },
        illuminate = true,
        neotest = true,
        notify = true,
        neogit = true,
    },
})

vim.cmd.colorscheme("catppuccin")
