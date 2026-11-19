vim.pack.add({
    { src = require("igorlfs.util").gh("neovim/nvim-lspconfig") },
})

vim.lsp.enable({ "jsonls", "oxfmt", "stylua", "svelte", "tsc" })
