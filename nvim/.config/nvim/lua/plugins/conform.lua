return {
    "stevearc/conform.nvim",
    event = { "LspAttach", "BufWritePre" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt" },
            markdown = { "injected", "markdownlint" },
            yaml = { "prettier" },
            typescript = { "prettier" },
            javascript = { "prettier" },
            http = { "injected" },
            json = { "jq" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
