return {
    "NeogitOrg/neogit",
    dependencies = {
        "esmuellert/codediff.nvim",
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
    },
    keys = { { "<leader>n", "<CMD>Neogit<CR>" } },
    cmd = "Neogit",
    opts = {
        commit_editor = {
            kind = "vsplit",
            show_staged_diff = false,
        },
        console_timeout = 5000,
        treesitter_diff_highlight = true,
        auto_show_console = false,
    },
}
