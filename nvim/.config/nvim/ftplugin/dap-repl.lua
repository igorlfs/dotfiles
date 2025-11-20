-- See https://github.com/vim/vim/issues/16903
vim.keymap.set("i", "<C-w>", "<C-S-w>", { buffer = true })

-- Enable builtin autocompletion
vim.bo[0].autocomplete = true

-- Disable blink.cmp's completion
vim.b.completion = false
