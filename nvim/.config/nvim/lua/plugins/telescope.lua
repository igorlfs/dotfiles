local tl = require("telescope")

tl.setup({
    tl.load_extension("fzy_native"),
    tl.load_extension("noice"),
})

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

keymap("n", "<leader>ff", builtin.find_files)
keymap("n", "<leader>fg", builtin.live_grep)
keymap("n", "<leader>fb", builtin.buffers)
