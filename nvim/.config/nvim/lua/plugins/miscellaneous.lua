require("catppuccin").setup({
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    integrations = {
        dap = {
            enabled = true,
            enable_ui = true,
        },
    }
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

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "comment", "make", "lua", "python", "vim", "norg" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
})

require("toggleterm").setup({
    open_mapping = [[<a-p>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})
