local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("neovim/nvim-lspconfig") },
})

for _, language_server in ipairs({
    "biome",
    "cssls",
    "dotls",
    "html",
    "hyprls",
    "jsonls",
    "lua_ls",
    "postgres_lsp",
    "ruff",
    "stylua",
    "svelte",
    "tailwindcss",
    "taplo",
    "tinymist",
    "ts_query_ls",
    "tsgo",
    "ty",
    "yamlls",
}) do
    vim.lsp.enable(language_server)
end
