local keymap = require("util").keymap
local str = string.format

keymap("<C-s>", "<CMD>write<CR>", "Quick Save")
keymap("<Esc>", [[<C-\><C-n>]], "Exit Terminal", "t")
keymap("<A-s>", "<CMD>setlocal spell!<CR>", "Toggle Spell")
keymap("x", '"_x', "Delete without overriding clipboard register", { "n", "x" })

-- Move within visual lines
keymap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }, { "n", "x" })
keymap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }, { "n", "x" })

-- Windows
keymap("<C-w>e", "<CMD>term<CR>", "Terminal")
keymap("<C-w>m", "<CMD>vnew<CR>", "New File Vertical Split")
keymap("<A-w>", function()
    if vim.wo.diff then
        vim.cmd.windo("diffoff")
    else
        vim.cmd.windo("diffthis")
    end
end, "Toggle Window Diff")

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

-- Kitty-style function keys for Neovide, foot, ...
for i = 1, 12 do
    keymap(
        string.format("<S-F%s>", i),
        string.format("<F%s>", i + 12),
        { desc = string.format("Shifted Function Key %s", i), remap = true }
    )
end

-- Saner behavior for n/N
-- Stolen from lazyvim https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap("n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" }, { "x", "o" })
keymap("N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap("N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" }, { "x", "o" })
