local status, lspconfig = pcall(require, "lspconfig")

if not status then
    vim.notify("lspconfig not found")
    return
end

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

-- C,C++
lspconfig.clangd.setup({
    cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
    on_attach = function(_, bufnr)
        vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
    end,
    capabilities = require("plugins.util").capabilities,
})

-- Rust
local rust_status, rust_tools = pcall(require, "rust-tools")
if rust_status then
    rust_tools.setup({
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            end,
            capabilities = require("plugins.util").capabilities,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        },
        tools = {
            hover_actions = {
                auto_focus = true,
            },
        },
        dap = {
            adapter = require("plugins.util").codelldb,
        },
    })
else
    vim.notify("rust-tools not installed, skipping rust setup")
end

local schemastore_status, schemastore = pcall(require, "schemastore")
if schemastore_status then
    -- JSON
    lspconfig.jsonls.setup({
        capabilities = require("plugins.util").capabilities,
        settings = {
            json = {
                schemas = schemastore.json.schemas(),
                validate = { enable = true },
            },
        },
    })

    -- YAML
    lspconfig.yamlls.setup({
        capabilities = require("plugins.util").capabilities,
        settings = {
            yaml = {
                schemas = schemastore.yaml.schemas(),
            },
        },
    })
else
    vim.notify("Schemastore not installed, skipping JSON/YAML setup")
end

-- Lua
-- Has to be initialized here to avoid race condition
local lua_status, neodev = pcall(require, "neodev")
if lua_status then
    neodev.setup()
end

-- Others
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
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = require("plugins.util").capabilities,
    })
end

-- Enable border for LspInfo
require("lspconfig.ui.windows").default_options.border = "rounded"
