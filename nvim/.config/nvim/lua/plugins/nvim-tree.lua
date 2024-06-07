return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<A-e>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
    },
    opts = {
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = false,
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        view = {
            adaptive_size = true,
        },
    },
}
