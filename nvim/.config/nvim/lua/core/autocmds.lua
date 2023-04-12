local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local clear = vim.api.nvim_clear_autocmds
local keymap = vim.keymap.set

-- Disable newline comments when inserting lines with o/O
local defaults = ag("Defaults", {})
au("FileType", {
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions:remove("o")
    end,
})

-- Unclutter terminal
au("Termopen", {
    group = defaults,
    pattern = { "*" },
    command = "setlocal nonumber norelativenumber scrolloff=0",
})

-- Spell
au("FileType", {
    group = defaults,
    pattern = { "gitcommit", "tex" },
    command = "setlocal spell",
})

-- Build with C/C++
au("FileType", {
    group = ag("Cpp", {}),
    pattern = { "cpp", "c", "make" },
    callback = function()
        keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true })
    end,
})

-- Common Jukit mappings for python and ipynb
local jukit = ag("Jukit", {})
au("FileType", {
    group = jukit,
    pattern = { "python", "json" },
    callback = function()
        keymap("n", "<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>")
    end,
})

-- Reload packer
au("BufWritePost", {
    group = ag("packer", {}),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

-- Autoformat on save
local lsp_group = ag("lsp", { clear = false })
au("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.supports_method("textDocument/formatting") then
            au("BufWritePre", {
                clear({ group = lsp_group, buffer = bufnr }),
                group = lsp_group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(c)
                            return c.name ~= "lua_ls" and c.name ~= "jsonls"
                        end,
                    })
                end,
            })
        end
    end,
})

-- LSP keymaps
au("LspAttach", {
    group = lsp_group,
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client.server_capabilities.hoverProvider then
            keymap("n", "K", require("core.util").peek_or_show_documentation, opts)
        end

        -- Defaults
        local lsp = vim.lsp.buf
        if client.server_capabilities.declarationProvider then
            keymap("n", "gD", lsp.declaration, opts)
        end
        if client.server_capabilities.signatureHelpProvider then
            keymap({ "n", "i" }, "<C-k>", lsp.signature_help, opts)
        end
        if client.server_capabilities.renameProvider then
            keymap("n", "<space>rn", lsp.rename, opts)
        end
        if client.server_capabilities.codeActionProvider then
            keymap({ "n", "v" }, "<space>ca", lsp.code_action, opts)
        end
        if client.server_capabilities.documentFormattingProvider then
            keymap("n", "<space>f", function()
                lsp.format({ async = true })
            end, opts)
        end
        keymap("n", "<space>wa", lsp.add_workspace_folder, opts)
        keymap("n", "<space>wr", lsp.remove_workspace_folder, opts)
        keymap("n", "<space>wl", function()
            print(vim.inspect(lsp.list_workspace_folders()))
        end, opts)

        -- Telescope Stuff
        local builtin = require("telescope.builtin")
        if client.server_capabilities.definitionProvider then
            keymap("n", "gd", builtin.lsp_definitions, opts)
        end
        if client.server_capabilities.implementationProvider then
            keymap("n", "gi", builtin.lsp_implementations, opts)
        end
        if client.server_capabilities.typeDefinitionProvider then
            keymap("n", "<space>D", builtin.lsp_type_definitions, opts)
        end
        if client.server_capabilities.referencesProvider then
            keymap("n", "gr", function()
                builtin.lsp_references({ show_line = false })
            end, opts)
        end
        if client.server_capabilities.callHierarchyProvider then
            keymap("n", "<leader>ic", builtin.lsp_incoming_calls, opts)
            keymap("n", "<leader>oc", builtin.lsp_outgoing_calls, opts)
        end
        if client.server_capabilities.documentSymbolProvider then
            keymap("n", "<leader>ds", builtin.lsp_document_symbols, opts)
        end

        -- Note: diagnostics are NOT specific to LSP
        keymap("n", "<leader>E", builtin.diagnostics, opts)
    end,
})

-- Winbar config
au("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
    end,
})
