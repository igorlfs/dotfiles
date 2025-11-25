local M = {}

local api = vim.api

M.get_mode_hl = function()
    local mode = api.nvim_get_mode().mode
    local mini_mode = "MiniStatuslineMode"

    -- These groups are enabled because catppuccin detects mini.ai and enables all of mini's hl groups

    if vim.startswith(mode, "i") or mode == "t" then
        return mini_mode .. "Insert"
    elseif vim.startswith(mode, "n") then
        return mini_mode .. "Normal"
    elseif vim.startswith(mode, "R") then
        return mini_mode .. "Replace"
    elseif vim.startswith(mode:lower(), "v") then
        return mini_mode .. "Visual"
    elseif mode == "c" then
        return mini_mode .. "Command"
    else
        return mini_mode .. "Other"
    end
end

return M
