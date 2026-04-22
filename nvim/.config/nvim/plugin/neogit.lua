local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-lua/plenary.nvim") },
    { src = util.gh("dlyongemallo/diffview.nvim") },
    { src = util.gh("ibhagwan/fzf-lua") },
    { src = util.gh("NeogitOrg/neogit") },
})

require("neogit").setup({
    commit_editor = {
        kind = "vsplit",
        show_staged_diff = false,
    },
    console_timeout = 5000,
    treesitter_diff_highlight = true,
    auto_show_console = false,
})

util.keymap("<leader>n", "<CMD>Neogit<CR>")
