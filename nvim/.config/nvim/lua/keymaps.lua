local str = string.format

local util = require("igorlfs.util")

local keymap = util.keymap
local feedkeys = util.feedkeys
local pumvisible = util.pumvisible

-- Basics

keymap("<C-s>", "<CMD>write<CR>", "Quick Save")
keymap("<Esc>", [[<C-\><C-n>]], "Exit Terminal", "t")
keymap("<A-s>", "<CMD>setlocal spell!<CR>", "Toggle Spell")

-- Clipboard

keymap("x", '"_x', "Delete without overriding clipboard register", { "n", "x" })
keymap("p", "P", "Paste without overriding clipboard register", { "x" })

-- Movement

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

---- Miscellaneous

-- Kitty-style function keys for Neovide, foot, ...
for i = 1, 12 do
    keymap(str("<S-F%s>", i), str("<F%s>", i + 12), { remap = true })
end

-- Autocompletion

keymap("<Tab>", function()
    if pumvisible() then
        feedkeys("<C-n>")
    else
        feedkeys("<Tab>")
    end
end, {}, "i")
keymap("<S-Tab>", function()
    if pumvisible() then
        feedkeys("<C-p>")
    else
        feedkeys("<S-Tab>")
    end
end, {}, "i")
keymap("<CR>", function()
    if pumvisible() then
        feedkeys("<C-y>")
    else
        feedkeys("<CR>")
    end
end, {}, "i")
