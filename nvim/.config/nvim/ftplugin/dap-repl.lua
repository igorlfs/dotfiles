-- See https://github.com/vim/vim/issues/16903
vim.keymap.set("i", "<C-w>", "<C-S-w>", { buf = 0 })

vim.wo[0][0].wrap = true

-- disable blink completion
vim.b.completion = false

vim.bo[0].autocomplete = true
vim.bo[0].complete = ".,o"
