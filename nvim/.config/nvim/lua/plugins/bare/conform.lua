return {
    "stevearc/conform.nvim",
    event = { "LspAttach", "BufWritePre" },
    opts = {
        formatters = {
            ["biome"] = { require_cwd = true },
            ["biome-check"] = { require_cwd = true },
            ["biome-organize-imports"] = { require_cwd = true },
            injected = {
                options = {
                    lang_to_formatters = {
                        json = { "jq" },
                    },
                },
            },
            jq = {
                prepend_args = { "--indent", "4" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            markdown = { "injected", "markdownlint" },
            typescript = { "biome-check", "prettier", stop_after_first = true },
            javascript = { "biome-check", "prettier", stop_after_first = true },
            json = { "biome" },
            http = { "injected" },
            svelte = { "biome-organize-imports", lsp_format = "first" },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return
            end
            local lsp_first = vim.tbl_contains({ "svelte" }, vim.bo[bufnr].filetype)
            return { timeout_ms = 1000, lsp_format = lsp_first and "first" or "fallback" }
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
