local severity = vim.diagnostic.severity

local icons = {
    [severity.ERROR] = " ",
    [severity.WARN] = " ",
    [severity.INFO] = " ",
    [severity.HINT] = "󰌵",
}

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
        text = icons,
    },
    status = {
        text = icons,
    },
    float = {
        style = "minimal",
        source = true,
        header = "",
        prefix = "",
    },
    severity_sort = true,
})
