vim.lsp.linked_editing_range.enable(true)

vim.lsp.config("*", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                -- Enable file watching for LSP
                --
                -- It's disabled because the default implementation is considered slow.
                dynamicRegistration = true,
            },
        },
    },
})
