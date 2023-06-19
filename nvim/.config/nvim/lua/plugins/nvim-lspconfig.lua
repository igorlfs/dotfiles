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

-- Icons
local icons = { Error = "󰅚 ", Warn = "󰀪 ", Info = "󰋽 ", Hint = "󰌶 " }
for type, icon in pairs(icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local servers = {
    "pylance",
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
    dependencies = {
        { "folke/neodev.nvim", config = true },
        { "williamboman/mason-lspconfig.nvim", config = true },
    },
    config = function()
        -- Enable border for LspInfo
        require("lspconfig.ui.windows").default_options.border = "rounded"

        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({
                capabilities = require("util").capabilities,
            })
        end

        require("lspconfig").texlab.setup({
            capabilities = require("util").capabilities,
            settings = {
                -- Vimtex's tectonic support can't handle "cotinuous compilation" so we texlab's build instead.
                -- However, vimtex provides a nice command for inverse search, so it's worth keeping around
                texlab = {
                    build = {
                        executable = "tectonic",
                        args = { "-X", "compile", "%f", "--synctex", "--keep-intermediates" },
                        forwardSearchAfter = true,
                        onSave = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "--synctex-forward", "%l:1:%f", "%p" },
                    },
                },
            },
        })

        require("lspconfig").clangd.setup({
            cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
            end,
            capabilities = require("util").capabilities,
        })
    end,
}
