local keymap = vim.keymap.set
local str = string.format

keymap({ "n", "i" }, "<C-s>", "<CMD>write<CR>", { desc = "Quick Save" })
keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal" })
keymap("n", "<A-s>", "<CMD>setlocal spell!<CR>", { desc = "Toggle Spell" })
keymap("n", "x", '"_x', { desc = "Don't override clipboard register with x" })

-- Move within visual lines
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Tabs
for i = 1, 9 do
    keymap("n", str("<A-%s>", i), str("%sgt", i), { desc = str("Goto tab %s", i) })
end
keymap("n", "<A-0>", "<CMD>tablast<CR>", { desc = "Goto last tab" })
keymap("n", "<A-]>", "<CMD>tabnext<CR>", { desc = "Goto next tab" })
keymap("n", "<A-[>", "<CMD>tabprevious<CR>", { desc = "Goto prev tab" })
keymap("n", "<A-->", "<CMD>tabm-<CR>", { desc = "Move tab to the left" })
keymap("n", "<A-=>", "<CMD>tabm+<CR>", { desc = "Move tab to the right" })
keymap("n", "<A-'>", "<CMD>tab split<CR>", { desc = "Clone window in new tab" })

-- Diagnostics
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic Popup" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
