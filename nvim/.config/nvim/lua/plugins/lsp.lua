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

local function peek_or_show_documentation()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        local filetype = vim.bo.filetype
        if vim.tbl_contains({ "vim", "help" }, filetype) then
            vim.cmd("h " .. vim.fn.expand("<cword>"))
        elseif vim.tbl_contains({ "man" }, filetype) then
            vim.cmd("Man " .. vim.fn.expand("<cword>"))
        elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
        else
            vim.lsp.buf.hover()
        end
    end
end

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
    keymap("n", "K", peek_or_show_documentation, bufopts)
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

    -- Winbar
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

-- Add additional capabilities supported by nvim-cmp
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Enable additional completion for HTML/JSON/CSS
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
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
    on_attach = function(client, bufnr)
        M.on_attach(client, bufnr)
        keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>")
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
        on_attach = function(client, bufnr)
            M.on_attach(client, bufnr)
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
        adapter = require("plugins.dap.main").codelldb,
    },
})

-- General config
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers =
    { "pylsp", "tsserver", "texlab", "lua_ls", "taplo", "gradle_ls", "jsonls", "yamlls", "ruff_lsp", "bashls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
    })
end

return M
