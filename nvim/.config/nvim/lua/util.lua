M = {}

---Utility for keymap creation
---@param lhs string
---@param rhs string|function
---@param opts string|vim.keymap.set.Opts
---@param mode? string|string[]
function M.keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts } or opts --[[@as vim.keymap.set.Opts]]
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps
---@param keys string
function M.feedkeys(keys) vim.api.nvim_feedkeys(vim.keycode(keys), "n", true) end

---Is the completion menu open?
function M.pumvisible() return tonumber(vim.fn.pumvisible()) ~= 0 end

return M
