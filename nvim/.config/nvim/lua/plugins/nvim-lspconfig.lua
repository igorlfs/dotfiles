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
    severity_sort = true,
})

local servers = {
    "pylance",
    "tsserver",
    "taplo",
    "gradle_ls",
    "ruff_lsp",
    "bashls",
    "yamlls",
    "julials",
    "html",
    "cssls",
    "emmet_language_server",
    "dotls",
    "gdscript",
    "svelte",
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "folke/neodev.nvim", config = true },
        -- Enable additional capabilities (i.e., autocompletion)
        "hrsh7th/cmp-nvim-lsp",
        -- Some servers (e.g., julials) would require additional configuration such as setting up the path
        -- mason-lspconfig bridges this gap and sets up everything to work perfectly with lspconfig
        { "williamboman/mason-lspconfig.nvim", config = true },
        -- Validate JSON files
        "b0o/schemastore.nvim",
    },
    config = function()
        -- Enable border for LspInfo
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- Some servers complain if not provided (e.g., yamlls)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({
                capabilities = capabilities,
            })
        end

        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { hint = { enable = true } } },
        })

        require("lspconfig").texlab.setup({
            capabilities = capabilities,
            settings = {
                -- Vimtex's tectonic support can't handle "continuous compilation" so we texlab's build instead.
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
            capabilities = capabilities,
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
            end,
        })

        require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
}
