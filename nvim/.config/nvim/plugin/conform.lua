local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("stevearc/conform.nvim") },
})

require("conform").setup({
    formatters = {
        injected = {
            options = {
                lang_to_formatters = {
                    json = { "jq" },
                },
            },
        },
    },
    formatters_by_ft = {
        markdown = { "injected", "markdownlint" },
        http = { "injected" },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
            return
        end

        ---@type table<string,conform.LspFormatOpts>
        local ft_to_lsp_format = {
            svelte = "first",
        }

        local ft = vim.bo[bufnr].filetype

        return {
            timeout_ms = 1000,
            lsp_format = ft_to_lsp_format[ft] or "fallback",
        }
    end,
})

util.keymap("<A-f>", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat

    -- Refresh statusline right after toggling autoformat, so it reflects instantly
    vim.cmd.redrawstatus()
end, "Toggle Format-on-Save")
