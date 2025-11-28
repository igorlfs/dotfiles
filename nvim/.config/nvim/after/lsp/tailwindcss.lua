local util = require("lspconfig.util")

---@type vim.lsp.Config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        local root_files = util.insert_package_json({}, "tailwindcss", fname)

        on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
    end,
}
