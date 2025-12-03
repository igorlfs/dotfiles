return {
    "stevearc/conform.nvim",
    event = { "LspAttach", "BufWritePre" },
    opts = {
        formatters = {
            ["biome"] = { require_cwd = true },
            ["biome-check"] = { require_cwd = true },
            ["biome-organize-imports"] = { require_cwd = true },
            ["prettier"] = { require_cwd = true },
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
            markdown = { "injected", "markdownlint" },
            typescript = { "biome-check", "prettier" },
            javascript = { "biome-check", "prettier" },
            json = { "biome" },
            jsonc = { "biome" },
            http = { "injected" },
            svelte = { "biome-organize-imports", lsp_format = "first" },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return
            end

            ---@type table<string,conform.LspFormatOpts>
            local ft_to_lsp_format = {
                svelte = "first",
                -- bqls's formatting sucks
                -- but to be fair, I'm not really happy with any SQL formatter
                sql = "never",
            }

            local ft = vim.bo[bufnr].filetype

            return {
                timeout_ms = 1000,
                lsp_format = ft_to_lsp_format[ft] or "fallback",
            }
        end,
    },
    keys = {
        {
            "<A-f>",
            function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat

                -- Refresh statusline right after toggling autoformat, so it reflects instantly
                vim.cmd.redrawstatus()
            end,
            desc = "Toggle Format-on-Save",
        },
    },
}
