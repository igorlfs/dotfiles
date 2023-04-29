local status, null_ls = pcall(require, "null-ls")

if not status then
    vim.notify("null_ls not found")
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    border = "rounded",
    sources = {
        -- Markdown
        formatting.markdownlint,

        -- TS / JS / JSON
        formatting.rome,

        -- SML
        formatting.smlfmt,

        -- Shell
        formatting.shfmt,

        -- SQL
        formatting.sqlfluff,

        -- YAML
        formatting.yamlfmt,

        -- Lua
        diagnostics.selene,
        formatting.stylua,

        -- Python
        formatting.black,

        -- C++
        diagnostics.cppcheck,
    },
})
