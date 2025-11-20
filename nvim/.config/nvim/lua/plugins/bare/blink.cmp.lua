return {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            accept = {
                -- See https://github.com/Saghen/blink.cmp/issues/1247
                -- Even outside neovide this can be annoying
                dot_repeat = false,
            },
            -- See https://github.com/Saghen/blink.cmp/issues/1770
            trigger = {
                show_on_blocked_trigger_characters = { " ", "\n", "\t", "$" },
            },
            documentation = {
                auto_show = true,
            },
            menu = {
                border = "none",
                draw = {
                    treesitter = { "lsp" },
                },
            },
            list = {
                selection = {
                    preselect = false,
                },
            },
        },
        cmdline = {
            keymap = {
                preset = "inherit",
            },
            completion = {
                menu = { auto_show = true },
                list = { selection = { preselect = false } },
            },
        },
        keymap = {
            preset = "enter",
            ["<Tab>"] = {
                "select_next",
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                "select_prev",
                "snippet_backward",
                "fallback",
            },
        },
    },
}
