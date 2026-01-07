return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>vo", "<CMD>DiffviewOpen<CR>", desc = "Diff Head" },
        { "<leader>vc", "<CMD>DiffviewFileHistory %<CR>", desc = "Diff Current File" },
    },
    opts = {
        keymaps = {
            view = {
                { "n", "q", "<CMD>DiffviewClose<CR>" },
            },
            file_panel = {
                { "n", "q", "<CMD>DiffviewClose<CR>" },
            },
            file_history_panel = {
                { "n", "q", "<CMD>DiffviewClose<CR>" },
            },
        },
    },
}
