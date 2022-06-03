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
require("utils")

map("n", "<leader>v", nt.toggle)
