vim.diagnostic.config({
    -- Limit length
    open_float = {
        width = 80,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
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
