local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("neovim/nvim-lspconfig") },
})

for _, language_server in ipairs({
    "jsonls",
    "oxfmt",
    "stylua",
    "svelte",
    "tinymist",
    "ts_query_ls",
    "tsc",
}) do
    vim.lsp.enable(language_server)
end
