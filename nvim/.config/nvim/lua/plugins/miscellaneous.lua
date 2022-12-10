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
    },
})

require("illuminate").configure({
    providers = {
        "lsp",
    },
})

require("indent_blankline").setup({
    max_indent_increase = 1,
    context_char = "│",
    show_current_context = true,
    show_trailing_blankline_indent = false,
})

require("mason").setup({
    ui = {
        border = "rounded",
    },
})

require("neorg").setup({
    load = {
        ["core.highlights"] = {
            config = {
                todo_items_match_color = "all",
            },
        },
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
    },
})

require("toggleterm").setup({
    open_mapping = [[<a-p>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})
