local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("nvim-lua/plenary.nvim") },
    { src = util.gh("nvim-tree/nvim-web-devicons") },
    { src = util.gh("ibhagwan/fzf-lua") },
    { src = util.gh("pwntester/octo.nvim") },
})

require("octo").setup({
    picker = "fzf-lua",
    ui = { conceallevel = 0 },
    poll = {
        enabled = true,
    },
    -- See https://github.com/pwntester/octo.nvim/issues/1162
    mappings_disable_default = true,
    mappings = {
        review_diff = {
            add_review_comment = { lhs = "<localleader>ca", desc = "add review comment", mode = { "n", "x" } },
            add_review_suggestion = { lhs = "<localleader>sa", desc = "add suggestion", mode = { "n", "x" } },
            select_next_entry = { lhs = "]q", desc = "move to next changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
            toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
        },
        file_panel = {
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            select_next_entry = { lhs = "]q", desc = "move to next changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
            toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
        },
    },
    reviews = {
        auto_show_threads = false,
    },
})

util.keymap("<leader>op", "<CMD>Octo pr list<CR>", "GH PR")

vim.treesitter.language.register("markdown", "octo")
