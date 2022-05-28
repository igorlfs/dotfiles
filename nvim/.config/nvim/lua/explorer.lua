require("nvim-tree").setup({
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
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>NvimTreeToggle<CR>", opts)
