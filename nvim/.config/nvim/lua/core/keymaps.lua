local keymap = vim.keymap.set
local str = string.format

-- Use space as leader
vim.g.mapleader = " "

-- Move within visual lines
keymap("n", "j", "gj")
keymap("n", "k", "gk")

-- Quick save
keymap("n", "<C-s>", ":write<CR>")

-- Quick exit terminal
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Tabs
-- Firefox-like movement
for i = 1, 9 do
    keymap("n", str("<A-%s>", i), str("%sgt", i))
end
keymap("n", "<A-0>", ":tablast<CR>", { silent = true })
-- Switch
keymap("n", "<A-tab>", ":tabnext<CR>", { silent = true })
keymap("n", "<S-tab>", ":tabprevious<CR>", { silent = true })
