local sign = vim.fn.sign_define

local dap_groups = { "DapBreakpoint", "DapBreakpointCondition" }

for _, group in pairs(dap_groups) do
    sign(group, { text = "●", texthl = group, numhl = "" })
end

local diagnostic_icons = { Error = "󰅚 ", Warn = "󰀪 ", Info = "󰋽 ", Hint = "󰌶 " }

for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type
    sign(hl, { text = icon, texthl = hl, numhl = hl })
end
