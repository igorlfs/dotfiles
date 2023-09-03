local keymap = vim.keymap.set
local str = string.format

keymap({ "n", "i" }, "<C-s>", "<cmd>write<CR>", { desc = "Quick Save" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal" })
keymap("n", "<A-s>", "<cmd>setlocal spell!<CR>", { desc = "Toggle Spell" })

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
keymap("n", "<A-]>", "<cmd>tabnext<CR>")
keymap("n", "<A-[>", "<cmd>tabprevious<CR>")
-- New tab
keymap("n", "<A-'>", "<cmd>tab split<CR>")

-- Diagnostics
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic Popup" })
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "[d", vim.diagnostic.goto_prev)
