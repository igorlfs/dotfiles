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
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },   
})

-- keymaps
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>NvimTreeToggle<CR>", opts)
