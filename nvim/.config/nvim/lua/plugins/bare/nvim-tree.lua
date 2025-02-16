return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "<A-e>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
        { "<A-E>", "<CMD>NvimTreeFindFileToggle<CR>", desc = "Toggle Find File" },
    },
    opts = {
        -- Might wanna sort considering numbers, see
        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#sorting-files-naturally-respecting-numbers-within-files-names
        -- Reference implementation does not take into account float numbers, though
        -- Also, it mixes both files and directories
        -- Both of these issues are fixable, for sure, but currently there's no strong need for this feature
        renderer = {
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
