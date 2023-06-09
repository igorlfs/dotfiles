-- Diagnostics
vim.diagnostic.config({
    -- Limit length
    open_float = {
        width = 80,
    },
    -- Enable border
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local servers = {
    "pylance",
    "texlab",
    "tsserver",
    "lua_ls",
    "taplo",
    "gradle_ls",
    "ruff_lsp",
    "bashls",
    "millet",
    "html",
    "cssls",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    config = function()
        -- Enable border for LspInfo
        require("lspconfig.ui.windows").default_options.border = "rounded"

        require("neodev").setup()

        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({
                capabilities = require("util").capabilities,
            })
        end

        require("lspconfig").clangd.setup({
            cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
            end,
            capabilities = require("util").capabilities,
        })
    end,
}
