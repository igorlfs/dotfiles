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

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
    local builtin = require("telescope.builtin")
    local bufopts = { silent = true, buffer = bufnr }
    keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap("n", "gd", builtin.lsp_definitions, bufopts)
    keymap("n", "K", vim.lsp.buf.hover, bufopts)
    keymap("n", "gi", builtin.lsp_implementations, bufopts)
    keymap({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap("n", "<leader>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, bufopts)
    keymap("n", "<leader>D", builtin.lsp_type_definitions, bufopts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    keymap("n", "gr", function()
        builtin.lsp_references({ show_line = false })
    end, bufopts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

    -- Telescope Stuff
    keymap("n", "<leader>ci", builtin.lsp_incoming_calls, bufopts)
    keymap("n", "<leader>co", builtin.lsp_outgoing_calls, bufopts)
    keymap("n", "<leader>sd", builtin.lsp_document_symbols, bufopts)
    keymap("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols, bufopts)
    keymap("n", "<leader>E", builtin.diagnostics, bufopts)

    local au = vim.api.nvim_create_autocmd
    local ag = vim.api.nvim_create_augroup
    local clear_au = vim.api.nvim_clear_autocmds

    -- Autoformat on save
    local augroup = ag("LspFormatting", { clear = false })
    if client.supports_method("textDocument/formatting") then
        au("BufWritePre", {
            clear_au({ group = augroup, buffer = bufnr }),
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end

    -- Server specific config
    if client.name == "clangd" then
        keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>")
    end

    if client.name == "jdtls" then
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()
        vim.lsp.codelens.refresh()
    end

    if client.name == "rust_analyzer" then
        local rt = require("rust-tools")
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    end
end

-- Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Enable additional completion for HTML/JSON/CSS
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")
-- Language specific config
-- C++
lspconfig.clangd.setup({
    cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
})

-- Lua
require("neodev").setup()

-- Rust
require("rust-tools").setup({
    server = {
        on_attach = M.on_attach,
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
        adapter = require("plugins.dap.main").codelldb,
    },
})

-- General config
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "pylsp", "tsserver", "texlab", "sumneko_lua", "taplo", "gradle_ls", "jsonls", "yamlls", "ruff_lsp" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
    })
end

return M
