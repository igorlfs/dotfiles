return {
    "jedrzejboczar/possession.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        autosave = {
            current = true,
            tmp = true,
            tmp_name = "__",
        },
    },
    keys = {
        { "<leader>fs", "<CMD>PossessionPick<CR>", desc = "Find Sessions" },
    },
    cmd = { "PossessionSave" },
}
