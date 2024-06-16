local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.keymap.set

local defaults = augroup("Defaults", {})

autocmd("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    pattern = { "*" },
    callback = function() vim.opt_local.formatoptions:remove("o") end,
})

autocmd("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

autocmd("FileType", {
    desc = "Disable foldcolumn",
    pattern = {
        "neotest-summary",
        "dap-repl",
        "NeogitCommitMessage",
        "NeogitCommitView",
        "NeogitPopup",
        "NeogitStatus",
        "NeogitDiffView",
    },
    callback = function() vim.opt_local.foldcolumn = "0" end,
})

-- This could be built-in (see nvim-dap#1194 for discussion)
autocmd("FileType", {
    desc = "Quit DAP-Float",
    pattern = { "dap-float" },
    callback = function() keymap("n", "q", "<C-w>q", { buffer = 0 }) end,
})

autocmd("BufWinEnter", {
    desc = "Set options on DAP-UI windows",
    group = augroup("set_dap_win_options", { clear = true }),
    pattern = { "DAP *" },
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        vim.schedule(function()
            if win and not vim.api.nvim_win_is_valid(win) then
                return
            end
            vim.api.nvim_set_option_value("foldcolumn", "0", { win = win })
        end)
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = defaults,
    callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage", "octo", "typst" },
    callback = function() vim.opt_local.spell = true end,
})

autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function() vim.wo.wrap = true end,
})

autocmd("LspAttach", {
    desc = "LSP",
    group = augroup("lsp", { clear = false }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local lsp = vim.lsp
        local methods = lsp.protocol.Methods

        -- Lenses
        if client and client.supports_method(methods.textDocument_codeLens) then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = 0,
                group = augroup("codelens", { clear = false }),
                callback = function() lsp.codelens.refresh({ bufnr = 0 }) end,
            })
        end

        -- Mappings
        keymap({ "n", "i" }, "<C-h>", lsp.buf.signature_help, { buffer = 0, desc = "Signature Help" })

        keymap(
            "n",
            "<A-h>",
            function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 }) end,
            { buffer = 0, desc = "Toggle Hints" }
        )

        keymap({ "n", "x" }, "<leader>la", lsp.buf.code_action, { buffer = 0, desc = "LSP Actions" })
        keymap("n", "<leader>ll", lsp.codelens.run, { buffer = 0, desc = "LSP Lens" })

        -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
        -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = 0, desc = "Go to Definition" })
        -- Similarly with LSP references, which is now mapped by default
        keymap("n", "grr", "<CMD>Telescope lsp_references<CR>", { buffer = 0, desc = "Find References" })
    end,
})
