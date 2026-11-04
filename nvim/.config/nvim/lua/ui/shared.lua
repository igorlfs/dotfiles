local M = {}

local api = vim.api

---@param mode string?
---@return string
M.get_mode_hl = function(mode)
    local mode_ = mode or api.nvim_get_mode().mode

    if vim.startswith(mode_, "i") or mode_ == "t" then
        return "ModeInsert"
    elseif vim.startswith(mode_, "n") then
        return "ModeNormal"
    elseif vim.startswith(mode_, "R") then
        return "ModeReplace"
    elseif vim.startswith(mode_:lower(), "v") then
        return "ModeVisual"
    elseif mode_ == "c" then
        return "ModeCommand"
    else
        return "ModeOther"
    end
end

return M
