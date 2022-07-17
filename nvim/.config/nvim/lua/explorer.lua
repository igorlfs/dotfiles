local nt = require("nvim-tree")

-- setup
nt.setup({
    renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = false,
          },
        },
        indent_markers = {
          enable = true,
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})

-- keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>v", nt.toggle)
