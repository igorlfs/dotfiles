local null_status, null_ls = pcall(require, "null-ls")
local embedded_status, embedded = pcall(require, "null-ls-embedded")

if not null_status then
    vim.notify("null-ls not found")
    return
end

if not embedded_status then
    vim.notify("null-ls-embedded not found")
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    border = "rounded",
    sources = {
        -- Markdown
        formatting.markdownlint,

        -- SML
        formatting.smlfmt,

        -- Shell
        formatting.shfmt,

        -- YAML
        formatting.yamlfmt,

        -- Lua
        diagnostics.selene,
        formatting.stylua,

        -- Python
        formatting.black,
        formatting.isort,

        -- C++
        diagnostics.cppcheck,

        -- Format inline code
        embedded.nls_source,
    },
})
