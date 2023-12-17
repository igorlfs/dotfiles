return {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    init = function()
        vim.g.rustaceanvim = {
            server = {
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
