local severity = vim.diagnostic.severity

vim.diagnostic.config({
    -- Limit length
    open_float = {
        width = 80,
    },
    signs = {
        numhl = {
            [severity.WARN] = "WarningMsg",
            [severity.ERROR] = "ErrorMsg",
            [severity.INFO] = "DiagnosticInfo",
            [severity.HINT] = "DiagnosticHint",
        },
    },
    -- Enable border
    float = {
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    severity_sort = true,
})
