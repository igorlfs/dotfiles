local M = {}

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
    local bufopts = { silent = true, buffer = bufnr }
    keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap("n", "K", vim.lsp.buf.hover, bufopts)
    keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap("n", "<leader>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, bufopts)
    keymap("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    keymap("n", "gr", vim.lsp.buf.references, bufopts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

    local au = vim.api.nvim_create_autocmd
    local ag = vim.api.nvim_create_augroup

    -- Server specific keymaps
    if client.name == "clangd" then
        keymap("n", "<A-o>", "<CMD>ClangdSwitchSourceHeader<CR>")
    end

    if client.supports_method("textDocument/formatting") then
        au("BufWritePre", {
            group = ag("LspFormatting", {}),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end

    if client.supports_method("textDocument/documentHighlight") then
        vim.cmd([[
            augroup LspHighlight
                autocmd! * <buffer>
                autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
                autocmd BufLeave * lua vim.lsp.buf.clear_references()
            augroup END 
        ]])
    end

    if client.name == "jdtls" then
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()
        vim.lsp.codelens.refresh()
    end
end

-- Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable borders
M.handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local lspconfig = require("lspconfig")
-- Language specific config
-- C++
lspconfig.clangd.setup({
    cmd = { "clangd", "--completion-style=detailed", "--clang-tidy", "--offset-encoding=utf-16" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    handlers = M.handlers,
})
-- Lua
lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    handlers = M.handlers,
})

-- General config
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "pyright", "tsserver", "eslint", "texlab" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        handlers = M.handlers,
    })
end
