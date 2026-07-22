local util = require("igorlfs.util")

local api = vim.api

vim.pack.add({
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
    graph_style = "unicode",
})

util.keymap("<leader>n", "<CMD>Neogit<CR>")

api.nvim_create_autocmd("FileType", {
    desc = "Reset statuscolumn for Neogit buffers",
    pattern = { "Neogit*" },
    callback = function()
        vim.wo[0][0].statuscolumn = ""
    end,
})
