return {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        fuzzy = {
            implementation = "lua",
        },
        sources = {
            -- Leverage builtin dap completion to create a more "automatic" completion
            per_filetype = { ["dap-repl"] = { "omni" } },
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
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
