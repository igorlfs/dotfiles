return {
    "jedrzejboczar/possession.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        autosave = {
            current = true,
        },
        plugins = {
            -- Force deleting fzf-lua's "hidden" terminal (last search)
            delete_hidden_buffers = {
                force = function(buf) return vim.bo[buf].buftype == "terminal" end,
            },
        },
    },
    keys = {
        { "<leader>fs", "<CMD>PossessionPick<CR>", desc = "Find Sessions" },
    },
    cmd = { "PossessionSave" },
}
