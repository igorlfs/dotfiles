return {
    "jedrzejboczar/possession.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        autosave = {
            current = true,
        },
    },
    keys = {
    },
    cmd = { "PossessionSave" },
    init = function() vim.opt.sessionoptions:remove({ "buffers" }) end,
}
