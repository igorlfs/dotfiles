-- Enable git highlight
vim.g.nvim_tree_git_hl = 1

-- Disable git icons
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
})

-- keymaps
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

map("n", "<leader>v", "<cmd>NvimTreeToggle<CR>", opts)
