vim.pack.add({
    { src = require("igorlfs.util").gh("neovim/nvim-lspconfig") },
})

for _, language_server in ipairs({
    "jsonls",
    "oxfmt",
    "stylua",
    "svelte",
    "ts_query_ls",
    "tsc",
}) do
    vim.lsp.enable(language_server)
end
