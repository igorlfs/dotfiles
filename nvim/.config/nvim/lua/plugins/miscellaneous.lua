require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = vim.fn.stdpath("config") .. "/snippets",
})

-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>n", require("notify").dismiss)
