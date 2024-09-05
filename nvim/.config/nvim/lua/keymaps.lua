local keymap = require("util").keymap
local str = string.format

keymap("<C-s>", "<CMD>write<CR>", "Quick Save", { "i", "n" })
keymap("<Esc>", [[<C-\><C-n>]], "Exit Terminal", "t")
keymap("<A-s>", "<CMD>setlocal spell!<CR>", "Toggle Spell")
keymap("x", '"_x', "Don't override clipboard register with x")

-- Move within visual lines
keymap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Tabs
for i = 1, 9 do
    keymap(str("<A-%s>", i), str("%sgt", i), str("Goto tab %s", i))
end
keymap("<A-0>", "<CMD>tablast<CR>", "Goto last tab")
keymap("<A-]>", "<CMD>tabnext<CR>", "Goto next tab")
keymap("<A-[>", "<CMD>tabprevious<CR>", "Goto prev tab")
keymap("<A-->", "<CMD>tabm-<CR>", "Move tab to the left")
keymap("<A-=>", "<CMD>tabm+<CR>", "Move tab to the right")
keymap("<A-'>", "<CMD>tab split<CR>", "Clone window in new tab")
