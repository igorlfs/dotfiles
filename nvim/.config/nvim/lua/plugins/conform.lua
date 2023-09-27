return {
    "stevearc/conform.nvim",
    event = { "LspAttach", "BufWritePre" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            gdscript = { "gdformat" },
            markdown = { "cbfmt", "markdownlint" },
            yaml = { "prettier" },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
        },
        formatters = {
            cbfmt = {
                command = "cbfmt",
                args = {
                    "--config",
                    vim.fn.stdpath("config") .. "/cbfmt.toml",
                    "--parser",
                    "markdown",
                },
                stdin = true,
            },
        },
    },
}
