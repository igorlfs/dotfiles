return {
    "stevearc/conform.nvim",
    event = { "LspAttach", "BufWritePre" },
    opts = {
        formatters = {
            ["biome-check"] = { require_cwd = true },
            injected = {
                options = {
                    lang_to_formatters = {
                        json = { "jq" },
                    },
                },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt" },
            markdown = { "injected", "markdownlint" },
            yaml = { "prettier" },
            typescript = { "biome-check", "prettier", stop_after_first = true },
            javascript = { "prettier" },
            http = { "injected" },
        },
        format_on_save = function()
            if vim.g.disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    },
    keys = {
        {
            "<A-f>",
            function() vim.g.disable_autoformat = not vim.g.disable_autoformat end,
            desc = "Toggle Format-on-Save",
        },
    },
}
