local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local clear_au = vim.api.nvim_clear_autocmds

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    on_attach = function(client, bufnr)
        local augroup = ag("NulllsFormatting", { clear = false })
        -- Autoformat on save
        if client.supports_method("textDocument/formatting") then
            au("BufWritePre", {
                clear_au({ group = augroup, buffer = bufnr }),
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
    border = "rounded",
    sources = {
        diagnostics.todo_comments,

        -- Python
        diagnostics.ruff,
        diagnostics.mypy,
        diagnostics.pylint,

        formatting.isort,
        formatting.black,

        -- Lua
        formatting.stylua,
    },
})
