return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>vo", "<CMD>DiffviewOpen<CR>", desc = "Diff Head" },
        { "<leader>vc", "<CMD>DiffviewFileHistory %<CR>", desc = "Diff Current File" },
    },
    config = function()
        local actions = require("diffview.actions")

        require("diffview").setup({
            file_panel = {
                win_config = {
                    position = "bottom",
                    height = 10,
                },
            },
            keymaps = {
                view = {
                    { "n", "q", actions.close, { desc = "DiffviewClose" } },
                },
                file_panel = {
                    -- actions.close closes only the file_panel window
                    { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "DiffviewClose" } },
                },
                file_history_panel = {
                    -- similarly, actions.close closes only the file_history_panel window
                    { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "DiffviewClose" } },
                },
            },
        })
    end,
}
