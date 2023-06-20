local keymap = vim.keymap.set
local str = string.format

-- Use space as leader
vim.g.mapleader = " "

-- Quick command mode
keymap("n", "ç", ":")

-- Quick save
-- Prefer "<cmd>" over ":" as to not trigger mode-changes and messages
keymap("n", "<C-s>", "<cmd>write<CR>")

-- Quick exit terminal
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Toggle spell checking
keymap("n", "<leader>s", "<cmd>setlocal spell!<CR>")

-- Move within visual lines
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Tabs
-- Movement
for i = 1, 9 do
    keymap("n", str("<A-%s>", i), str("%sgt", i))
end
keymap("n", "<A-0>", "<cmd>tablast<CR>")
-- Switch
keymap("n", "<A-tab>", "<cmd>tabnext<CR>")
keymap("n", "<S-tab>", "<cmd>tabprevious<CR>")
-- New tab
keymap("n", "<A-t>", "<cmd>tab split<CR>")

-- Diagnostics (LSP)
keymap("n", "<space>e", vim.diagnostic.open_float)
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "<leader>q", vim.diagnostic.setloclist)
