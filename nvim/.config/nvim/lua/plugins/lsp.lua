local M = {}

-- Enable border for LspInfo
require("lspconfig.ui.windows").default_options.border = "rounded"

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

local keymap = vim.keymap.set

-- Diagnostic keymaps
keymap("n", "<space>e", vim.diagnostic.open_float)
keymap("n", "[d", vim.diagnostic.goto_prev)
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "<leader>q", vim.diagnostic.setloclist)

-- Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Add additional capabilities supported by UFO
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
-- Don't change fold level when opening and closing all folds
-- Otherwise UFO gets messed up
keymap("n", "zR", require("ufo").openAllFolds)
keymap("n", "zM", require("ufo").closeAllFolds)

local lspconfig = require("lspconfig")
-- Language specific config
-- C++
lspconfig.clangd.setup({
    cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
    on_attach = function(_, bufnr)
        keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
    end,
    capabilities = M.capabilities,
})

-- Lua
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- Rust
require("rust-tools").setup({
    server = {
        on_attach = function(_, bufnr)
            keymap("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
        end,
        capabilities = M.capabilities,
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
        adapter = require("plugins.dap.adapters").codelldb,
    },
})

-- Volar
-- In the future, we might wanna look into "takeover mode",
-- which allows volar to control tsserver and attach to JS/TS files,
-- and it's the "recommended" way of using both servers
--
-- However, this kind of sucks because we must disable tsserver
-- if we are into a vue project, which is cumbersome to configure
--
-- Enable takeover mode
-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
-- init_options = {
--     typescript = {
--         -- That's the path to the TS installation containing tsserver,
--         -- which is global in my setup, but could be based on current project configuration
--         tsdk = "/usr/lib/node_modules/typescript/lib/",
--     },
-- },

-- General config
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    "pylsp",
    "texlab",
    "tsserver",
    "lua_ls",
    "taplo",
    "gradle_ls",
    "jsonls",
    "yamlls",
    "ruff_lsp",
    "bashls",
    "volar",
    "html",
    "cssls",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = M.capabilities,
    })
end

return M
