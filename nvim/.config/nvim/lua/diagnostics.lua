local severity = vim.diagnostic.severity

vim.diagnostic.config({
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
    float = {
        style = "minimal",
        source = true,
        header = "",
        prefix = "",
    },
    severity_sort = true,
})
