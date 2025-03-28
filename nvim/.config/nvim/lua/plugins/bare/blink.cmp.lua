return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        sources = {
            -- Leverage builtin dap completion to create a more "automatic" completion
            per_filetype = { ["dap-repl"] = { "omni" } },
        },
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
        cmdline = {
            keymap = {
                preset = "none",
                ["<Tab>"] = {
                    "select_next",
                },
                ["<S-Tab>"] = {
                    "select_prev",
                },
                ["<CR>"] = { "accept", "fallback" },
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
