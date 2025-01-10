vim.lsp.config("*", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                -- Enable file watching for LSP
                --
                -- It's disabled because the default implementation is considered slow.
                -- I've tried using it but it straight up doesn't work for me.
                --
                -- Instead, use a custom backend.
                -- Requires `watchman` to be installed https://github.com/facebook/watchman
                dynamicRegistration = true,
            },
        },
    },
})
