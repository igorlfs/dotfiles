local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local clear = vim.api.nvim_clear_autocmds
local keymap = vim.keymap.set

local defaults = augroup("Defaults", {})

autocmd("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    pattern = { "*" },
    command = "setlocal formatoptions-=o",
})

autocmd("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        -- Use a fixed width to avoid resizing vim-jukit
        vim.opt_local.winfixwidth = true
        keymap("t", "<A-i>", "<C-\\><C-n><C-w>w")
    end,
})

autocmd("FileType", {
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    command = "setlocal spell",
})

autocmd("FileType", {
    desc = "Async build with C, C++",
    group = augroup("Cpp", {}),
    pattern = { "cpp", "c", "make" },
    callback = function() keymap("n", "<leader>m", "<cmd>Make<CR>", { buffer = true }) end,
})

autocmd("FileType", {
    desc = "Jukit convert notebooks",
    group = augroup("Jukit", {}),
    pattern = { "python", "json" },
    callback = function() keymap("n", "<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>") end,
})

local lsp_group = augroup("lsp", { clear = false })
autocmd("LspAttach", {
    desc = "LSP",
    group = lsp_group,
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Autoformat
        local excluded = { "lua_ls" }
        if client.supports_method("textDocument/formatting") then
            autocmd("BufWritePre", {
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

        -- Defaults
        local lsp = vim.lsp.buf

        if client.supports_method("textDocument/inlayHint") then
            keymap("n", "<leader>H", function() vim.lsp.inlay_hint(0, nil) end, opts)
        end

        if client.server_capabilities.hoverProvider then
            keymap("n", "K", lsp.hover, opts)
        end
        if client.server_capabilities.declarationProvider then
            keymap("n", "gD", lsp.declaration, opts)
        end
        if client.server_capabilities.signatureHelpProvider then
            keymap({ "n", "i" }, "<C-k>", lsp.signature_help, opts)
        end
        if client.server_capabilities.codeActionProvider then
            keymap({ "n", "v" }, "<leader>ca", lsp.code_action, opts)
        end
        keymap("n", "<leader>rn", lsp.rename, opts)
        keymap("n", "<leader>F", function() lsp.format({ async = true }) end, opts)
        keymap("n", "<leader>wl", function() print(vim.inspect(lsp.list_workspace_folders())) end, opts)
        keymap("n", "<leader>wa", lsp.add_workspace_folder, opts)
        keymap("n", "<leader>wr", lsp.remove_workspace_folder, opts)

        -- Telescope Stuff
        local builtin = require("telescope.builtin")
        keymap("n", "gd", builtin.lsp_definitions, opts)
        keymap("n", "gi", builtin.lsp_implementations, opts)
        keymap("n", "gr", function() builtin.lsp_references({ show_line = false }) end, opts)
        keymap("n", "<leader>D", builtin.lsp_type_definitions, opts)
        keymap("n", "<leader>ic", builtin.lsp_incoming_calls, opts)
        keymap("n", "<leader>oc", builtin.lsp_outgoing_calls, opts)
        keymap("n", "<leader>ds", builtin.lsp_document_symbols, opts)

        -- Note: diagnostics are NOT specific to LSP
        keymap("n", "<leader>E", builtin.diagnostics, opts)
    end,
})

autocmd({ "VimEnter", "DirChanged" }, {
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
