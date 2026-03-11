local severity = vim.diagnostic.severity

vim.diagnostic.config({
    signs = {
        numhl = {
            [severity.ERROR] = "ErrorMsg",
            [severity.WARN] = "WarningMsg",
            [severity.INFO] = "DiagnosticInfo",
            [severity.HINT] = "DiagnosticHint",
        },
    },
    status = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.INFO] = " ",
            [severity.HINT] = "󰌵",
        },
    },
    float = {
        source = true,
        header = "",
    },
    severity_sort = true,
})
