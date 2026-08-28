M = {}

local api = vim.api

---Utility for keymap creation
---@param lhs string
---@param rhs string|function
---@param opts? string|vim.keymap.set.Opts
---@param mode? string|string[]
function M.keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts } or opts --[[@as vim.keymap.set.Opts]]
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps
---@param keys string
function M.feedkeys(keys)
    vim.api.nvim_feedkeys(vim.keycode(keys), "n", true)
end

---Is the completion menu open?
function M.pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
end

---@param x string
function M.gh(x)
    return "https://github.com/" .. x
end

---@param client vim.lsp.Client
---@param buf integer
function M.lsp_auto_format(client, buf)
    if client:supports_method("textDocument/formatting", buf) then
        api.nvim_create_autocmd("BufWritePre", {
            buffer = buf,
            callback = function()
                if vim.g.disable_autoformat then
                    return
                end

                local clients = vim.iter(vim.lsp.get_clients({ bufnr = buf }))
                    :map(
                        ---@param cli vim.lsp.Client
                        function(cli)
                            return cli.name
                        end
                    )
                    :totable()

                if vim.tbl_contains(clients, "stylua") and client.name == "lua_ls" then
                    return
                end

                if vim.tbl_contains(clients, "oxfmt") and client.name == "tsc" then
                    return
                end

                vim.lsp.buf.format({ bufnr = buf, id = client.id })
            end,
        })
    end
end

return M
