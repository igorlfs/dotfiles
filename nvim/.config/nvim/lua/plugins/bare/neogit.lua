return {
    "NeogitOrg/neogit",
    dependencies = {
        "sindrets/diffview.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = { { "<leader>n", function() require("neogit").open() end, desc = "Neogit" } },
    cmd = "Neogit",
    opts = {
        commit_editor = {
            kind = "vsplit",
            show_staged_diff = false,
        },
        auto_show_console = false,
    },
}
