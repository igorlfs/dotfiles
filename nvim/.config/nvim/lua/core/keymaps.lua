local keymap = vim.keymap.set
local str = string.format

-- Use space as leader
vim.g.mapleader = " "

-- Move within visual lines
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quick save
-- Prefer "<cmd>" over ":" as to not trigger mode-changes and messages
keymap("n", "<C-s>", "<cmd>write<CR>")

-- Quick exit terminal
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Toggle spell checking
keymap("n", "<leader>s", ":setlocal spell!<CR>", { silent = true })

-- Tabs
-- Movement
for i = 1, 9 do
    keymap("n", str("<A-%s>", i), str("%sgt", i))
end
keymap("n", "<A-0>", "<cmd>tablast<CR>")
-- Switch
keymap("n", "<A-tab>", "<cmd>tabnext<CR>")
keymap("n", "<S-tab>", "<cmd>tabprevious<CR>")
