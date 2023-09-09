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

-- Icons
local icons = { Error = "󰅚 ", Warn = "󰀪 ", Info = "󰋽 ", Hint = "󰌶 " }
for type, icon in pairs(icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "folke/neodev.nvim", config = true },
        { "williamboman/mason-lspconfig.nvim", config = true },
        { "b0o/schemastore.nvim" },
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
            on_new_config = function(new_config)
                new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
                json = { validate = { enable = true } },
            },
        })
    end,
}
