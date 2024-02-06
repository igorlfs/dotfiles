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
    },
    callback = function() vim.opt_local.foldcolumn = "0" end,
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
    pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
    callback = function() vim.opt_local.spell = true end,
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

        keymap(
            "n",
            "<A-h>",
            function() lsp.inlay_hint.enable(nil, not lsp.inlay_hint.is_enabled(0)) end,
            { buffer = ev.buf, desc = "Toggle Hints" }
        )

        keymap({ "n", "v" }, "<leader>la", lsp.buf.code_action, { buffer = ev.buf, desc = "LSP Actions" })
        keymap("n", "<leader>lr", lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename" })
        keymap("n", "<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "LSP Lens" })

        -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
        -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "Go to Definition" })
    end,
})
