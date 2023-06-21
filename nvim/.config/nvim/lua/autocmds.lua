local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local clear = vim.api.nvim_clear_autocmds
local keymap = vim.keymap.set

local defaults = ag("Defaults", {})
au("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    pattern = { "*" },
    callback = function() vim.opt.formatoptions:remove("o") end,
})

au("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    pattern = { "*" },
    command = "setlocal nonumber norelativenumber scrolloff=0",
})

au("FileType", {
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    command = "setlocal spell",
})

au("FileType", {
    desc = "Async build with C, C++",
    group = ag("Cpp", {}),
    pattern = { "cpp", "c", "make" },
    callback = function() keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true }) end,
})

au("FileType", {
    desc = "Jukit convert notebooks",
    group = ag("Jukit", {}),
    pattern = { "python", "json" },
    callback = function() keymap("n", "<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>") end,
})

local lsp_group = ag("lsp", { clear = false })
au("LspAttach", {
    desc = "LSP",
    group = lsp_group,
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Inlay hints
        if client.supports_method("textDocument/inlayHint") then
            vim.lsp.buf.inlay_hint(ev.buf, true)
        end

        -- Autoformat
        local excluded = { "lua_ls" }
        if client.supports_method("textDocument/formatting") then
            au("BufWritePre", {
                clear({ group = lsp_group, buffer = ev.buf }),
                group = lsp_group,
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(c) return not vim.tbl_contains(excluded, c.name) end,
                    })
                end,
            })
        end

        if client.server_capabilities.hoverProvider then
            keymap("n", "K", vim.lsp.buf.hover, opts)
        end

        -- Defaults
        local lsp = vim.lsp.buf
        if client.server_capabilities.declarationProvider then
            keymap("n", "gD", lsp.declaration, opts)
        end
        if client.server_capabilities.signatureHelpProvider then
            keymap({ "n", "i" }, "<C-k>", lsp.signature_help, opts)
        end
        keymap("n", "<space>rn", lsp.rename, opts)
        if client.server_capabilities.codeActionProvider then
            keymap({ "n", "v" }, "<space>ca", lsp.code_action, opts)
        end
        keymap("n", "<space>F", function() lsp.format({ async = true }) end, opts)
        keymap("n", "<space>wa", lsp.add_workspace_folder, opts)
        keymap("n", "<space>wr", lsp.remove_workspace_folder, opts)
        keymap("n", "<space>wl", function() print(vim.inspect(lsp.list_workspace_folders())) end, opts)

        -- Telescope Stuff
        local builtin = require("telescope.builtin")
        keymap("n", "gd", builtin.lsp_definitions, opts)
        keymap("n", "gi", builtin.lsp_implementations, opts)
        keymap("n", "<space>D", builtin.lsp_type_definitions, opts)
        keymap("n", "gr", function() builtin.lsp_references({ show_line = false }) end, opts)
        keymap("n", "<leader>ic", builtin.lsp_incoming_calls, opts)
        keymap("n", "<leader>oc", builtin.lsp_outgoing_calls, opts)
        keymap("n", "<leader>ds", builtin.lsp_document_symbols, opts)

        -- Note: diagnostics are NOT specific to LSP
        keymap("n", "<leader>E", builtin.diagnostics, opts)
    end,
})

au({ "VimEnter", "DirChanged" }, {
    desc = "Venv autoselect",
    pattern = "*",
    callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
            require("venv-selector").retrieve_from_cache()
        end
    end,
    once = true,
})
