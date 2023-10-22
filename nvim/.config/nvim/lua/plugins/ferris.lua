return {
    "mrcjkb/ferris.nvim",
    ft = { "rust" },
    init = function()
        vim.g.ferris = {
            dap = {
                adapter = require("util").codelldb,
            },
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
