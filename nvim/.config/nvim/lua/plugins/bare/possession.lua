return {
    "jedrzejboczar/possession.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        autosave = {
            current = true,
        },
    },
    keys = {
        { "<leader>fs", "<CMD>Telescope possession list<CR>", desc = "Find Sessions" },
    },
    cmd = { "PossessionSave" },
    init = function() vim.opt.sessionoptions:remove({ "buffers" }) end,
}
