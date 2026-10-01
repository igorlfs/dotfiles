M = {}

local api = vim.api

---@param lhs string
---@param rhs string|function
---@param opts? string|vim.keymap.set.Opts
---@param mode? string|string[]
function M.keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts } or opts
    ---@cast opts vim.keymap.set.Opts
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps
---@param keys string
function M.feedkeys(keys)
    api.nvim_feedkeys(vim.keycode(keys), "n", true)
end

---Is the completion menu open?
---@return boolean
function M.pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
end

---@param x string
---@return string
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

                if
                    vim.tbl_contains(clients, "stylua")
                    and vim.tbl_contains({ "lua_ls", "emmylua_ls" }, client.name)
                then
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
