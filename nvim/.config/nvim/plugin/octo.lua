local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-lua/plenary.nvim") },
    { src = util.gh("nvim-tree/nvim-web-devicons") },
    { src = util.gh("ibhagwan/fzf-lua") },
    { src = util.gh("pwntester/octo.nvim") },
})

require("octo").setup({
    picker = "fzf-lua",
    poll = {
        enabled = true,
    },
    reviews = {
        auto_show_threads = false,
    },
})

util.keymap("<leader>op", "<CMD>Octo pr list<CR>", "GH PR")

vim.treesitter.language.register("markdown", "octo")
