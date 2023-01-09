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

require("indent_blankline").setup({
    max_indent_increase = 1,
    context_char = "│",
    show_current_context = true,
    show_trailing_blankline_indent = false,
})

require("toggleterm").setup({
    open_mapping = [[<a-p>]],
    direction = "float",
    float_opts = {
        border = "rounded",
    },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = vim.fn.stdpath("config") .. "/snippets",
})

-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>n", require("notify").dismiss)
