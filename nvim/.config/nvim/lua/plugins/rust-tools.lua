return {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {
        server = {
            on_attach = function(_, bufnr)
                local rust_tools = require("rust-tools")
                vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            end,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        },
        tools = {
            hover_actions = {
                auto_focus = true,
            },
            inlay_hints = {
                auto = false,
            },
        },
        dap = {
            adapter = require("util").codelldb,
        },
    },
}
