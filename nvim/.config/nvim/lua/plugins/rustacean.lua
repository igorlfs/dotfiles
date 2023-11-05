return {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    init = function()
        vim.g.rustaceanvim = {
            server = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
        }
    end,
}
