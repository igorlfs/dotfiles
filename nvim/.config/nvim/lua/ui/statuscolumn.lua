local api = vim.api

local M = {}

---@type string[]
local _ns = {}
---@param id integer
local function ns_name(id)
    if not _ns[id] then
        for name, nsid in pairs(api.nvim_get_namespaces()) do
            _ns[nsid] = name
        end
    end
    return _ns[id] or ""
end

---@param lnum integer
---@return [vim.api.keyset.extmark_details, vim.api.keyset.extmark_details]
local function get_signs(lnum)
    local signs = api.nvim_buf_get_extmarks(0, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true, type = "sign" })

    ---@type vim.api.keyset.extmark_details?
    local dap
    ---@type vim.api.keyset.extmark_details?
    local git
    for _, mark in ipairs(signs) do
        local details = mark[4]
        if details and details.sign_text then
            if details.sign_name and details.sign_name:match("^Dap") then
                if not dap or details.priority > dap.priority then
                    dap = details
                end
            elseif ns_name(details.ns_id):find("gitsigns") then
                if not git or details.priority > git.priority then
                    git = details
                end
            end
        end
    end

    return { dap, git }
end

---@param sign vim.api.keyset.extmark_details?
local function render_dap(sign)
    return sign and "%#" .. sign.sign_name .. "#" .. sign.sign_text .. "%*" or "  "
end

---@param sign vim.api.keyset.extmark_details?
local function render_git(sign)
    return sign and "%#" .. sign.sign_hl_group .. "#" .. sign.sign_text .. "%*" or "  "
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

    local signs = get_signs(vim.v.lnum)

    local dap = vim.v.virtnum == 0 and render_dap(signs[1]) or "  "

    local bare = number_line() .. render_git(signs[2])

    if vim.bo[0].modifiable then
        return dap .. bare
    else
        return bare
    end
end

vim.o.statuscolumn = "%{%v:lua.require('ui.statuscolumn').render()%}"

return M
