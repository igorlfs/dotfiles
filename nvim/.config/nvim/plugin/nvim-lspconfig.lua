local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("neovim/nvim-lspconfig") },
})

for _, language_server in ipairs({
    "jsonls",
    "oxfmt",
    "ruff",
    "stylua",
    "svelte",
    "tailwindcss",
    "tinymist",
    "ts_query_ls",
    "tsc",
    "ty",
    "yamlls",
}) do
    vim.lsp.enable(language_server)
end
