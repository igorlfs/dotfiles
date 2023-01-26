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

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = vim.fn.stdpath("config") .. "/snippets",
})

-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>n", require("notify").dismiss)
