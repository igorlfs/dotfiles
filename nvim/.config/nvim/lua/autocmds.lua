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
    desc = "Enable spellchecker",
    group = defaults,
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    callback = function() vim.opt_local.spell = true end,
})

autocmd("FileType", {
    desc = "Disable foldcolumn",
    group = defaults,
    pattern = {
        "neotest-summary",
        "dap-repl",
        "NeogitCommitMessage",
        "NeogitCommitView",
        "NeogitStatus",
    },
    callback = function() vim.opt_local.foldcolumn = "0" end,
})

autocmd("LspAttach", {
    desc = "LSP",
    group = augroup("lsp", { clear = false }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local lsp = vim.lsp

        -- Lenses
        if client and client.supports_method(lsp.protocol.Methods.textDocument_codeLens) then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = ev.buf,
                group = augroup("codelens", { clear = false }),
                callback = function() lsp.codelens.refresh() end,
            })
        end

        -- Mappings
        keymap({ "n", "i" }, "<C-h>", lsp.buf.signature_help, { buffer = ev.buf })

        keymap("n", "<A-h>", function() lsp.inlay_hint(0, nil) end, { buffer = ev.buf, desc = "Toggle Hints" })

        keymap({ "n", "v" }, "<leader>la", lsp.buf.code_action, { buffer = ev.buf, desc = "[L]SP [A]ctions" })
        keymap("n", "<leader>lr", lsp.buf.rename, { buffer = ev.buf, desc = "[L]SP [R]ename" })
        keymap("n", "<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "[L]SP [L]ens" })

        -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
        -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "[G]o to [D]efinition" })
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = augroup("highlight_yank", {}),
    callback = function() vim.highlight.on_yank() end,
})
