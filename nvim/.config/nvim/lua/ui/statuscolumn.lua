local api = vim.api

local M = {}

---@param lnum integer
local function get_signs(lnum)
    local signs = api.nvim_buf_get_extmarks(0, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true, type = "sign" })

    ---@type vim.api.keyset.extmark_details?
    local dap
    for _, mark in ipairs(signs) do
        local details = mark[4]
        if details and details.sign_text then
            if details.sign_name and details.sign_name:match("^Dap") then
                if not dap or details.priority > dap.priority then
                    dap = details
                end
            end
        end
    end

    return dap
end

---@param sign vim.api.keyset.extmark_details?
local function render_dap(sign)
    return sign and "%#" .. sign.sign_name .. "#" .. sign.sign_text .. "%*" or "  "
end

local function number_line()
    local v = vim.v
    if v.virtnum ~= 0 then
        return "%="
    end

    local lnum = v.relnum > 0 and v.relnum or v.lnum
    local lnum_str = tostring(lnum)
    local pad = (" "):rep(vim.wo.numberwidth - #lnum_str)
    return "%=" .. pad .. lnum_str .. " "
end

M.render = function()
    if vim.bo[0].buftype == "quickfix" then
        return number_line()
    end

    local dap_signs = get_signs(vim.v.lnum)

    local dap = vim.v.virtnum == 0 and render_dap(dap_signs) or "  "

    local bare = number_line()

    if package.loaded["gitsigns"] then
        bare = bare .. require("gitsigns").statuscolumn()
    end

    if vim.bo[0].modifiable then
        return dap .. bare
    else
        return bare
    end
end

vim.o.statuscolumn = "%{%v:lua.require('ui.statuscolumn').render()%}"

return M
