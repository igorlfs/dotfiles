-- Signs
local sign = vim.fn.sign_define

local dap_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected" }

for _, group in pairs(dap_groups) do
    sign(group, { text = "●", texthl = group, numhl = "" })
end

local diagnostic_icons = { Error = "󰅚 ", Warn = "󰀪 ", Info = "󰋽 ", Hint = "󰌶 " }

for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type
    sign(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Search
-- Autoclear searches
vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
