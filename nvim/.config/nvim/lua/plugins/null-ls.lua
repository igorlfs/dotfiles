local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local group_format = augroup("LspFormatting", {})

null_ls.setup({
    on_attach = function(client, bufnr)
        -- Autoformat on save
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = group_format, buffer = bufnr })
            autocmd("BufWritePre", {
                group = group_format,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    sources = {
        diagnostics.todo_comments,

        -- Python
        formatting.isort,
        formatting.black,
        diagnostics.flake8,
        diagnostics.pylint,
    },
})
