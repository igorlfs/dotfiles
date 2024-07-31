return {
    "NeogitOrg/neogit",
    dependencies = {
        "sindrets/diffview.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    opts = {
        commit_editor = {
            kind = "vsplit",
            show_staged_diff = false,
        },
        console_timeout = 5000,
        auto_show_console = false,
    },
}
