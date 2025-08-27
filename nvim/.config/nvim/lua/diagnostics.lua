local severity = vim.diagnostic.severity

vim.diagnostic.config({
    open_float = {
        width = 80,
    },
    signs = {
        numhl = {
            [severity.ERROR] = "ErrorMsg",
            [severity.WARN] = "WarningMsg",
            [severity.INFO] = "DiagnosticInfo",
            [severity.HINT] = "DiagnosticHint",
        },
        text = {
            [severity.ERROR] = "",
            [severity.WARN] = "",
            [severity.INFO] = "",
            [severity.HINT] = "󰌵",
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
