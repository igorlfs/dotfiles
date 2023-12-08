vim.diagnostic.config({
    -- Limit length
    open_float = {
        width = 80,
    },
    -- Enable border
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    severity_sort = true,
})

-- Signs
local sign = vim.fn.sign_define

local diagnostic_icons = { Error = "󰅚 ", Warn = "󰀪 ", Info = "󰋽 ", Hint = "󰌶 " }

for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type
    sign(hl, { text = icon, texthl = hl, numhl = hl })
end
