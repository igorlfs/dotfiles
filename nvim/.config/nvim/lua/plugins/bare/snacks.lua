return {
    "folke/snacks.nvim",
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
        picker = {
            win = {
                input = {
                    keys = {
                        ["<TAB>"] = { "list_down", mode = { "i", "n" } },
                        ["<S-TAB>"] = { "list_up", mode = { "i", "n" } },
                        ["<C-n>"] = { "select_and_next", mode = { "i", "n" } },
                        ["<C-p>"] = { "select_and_prev", mode = { "i", "n" } },
                    },
                },
            },
        },
    },
}
