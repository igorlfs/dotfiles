M = {}

---Utility for keymap creation.
---@param lhs string
---@param rhs string|function
---@param opts string|table
---@param mode? string|string[]
function M.keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts } or opts --[[@as table]]
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
