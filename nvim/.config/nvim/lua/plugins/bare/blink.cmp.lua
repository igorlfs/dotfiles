return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            accept = {
                -- See https://github.com/Saghen/blink.cmp/issues/1247
                dot_repeat = false,
                auto_brackets = {
                    enabled = true,
                },
            },
            documentation = {
                auto_show = true,
            },
            menu = {
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
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },
    },
}
