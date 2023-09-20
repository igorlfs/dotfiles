return {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            gdscript = { "gdformat" },
            markdown = { "cbfmt", "markdownlint" },
        },
        format_on_save = {
            timeout_ms = 500,
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
