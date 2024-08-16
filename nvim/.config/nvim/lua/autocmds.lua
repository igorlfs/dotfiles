local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.keymap.set

local defaults = augroup("Defaults", {})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("Checktime", {}),
    desc = "Check if we need to reload the file when it changed",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

autocmd("FileType", {
    desc = "Disable newline comments when inserting lines with o/O",
    group = defaults,
    pattern = { "*" },
    callback = function() vim.opt_local.formatoptions:remove("o") end,
})

autocmd("FileType", {
    desc = "Disable remove a comment leader when joining lines, as it consumes some unwanted characters",
    pattern = { "svelte" },
    callback = function() vim.opt_local.formatoptions:remove("j") end,
})

autocmd("Termopen", {
    desc = "Unclutter terminal",
    group = defaults,
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        vim.opt_local.foldcolumn = "0"
    end,
})

autocmd("FileType", {
    desc = "Enable Softwrap",
    group = defaults,
    pattern = { "tex", "octo", "typst", "markdown" },
    callback = function() vim.opt_local.wrap = true end,
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

autocmd("FileType", {
    desc = "Align CSV",
    pattern = { "csv" },
    callback = function(args)
        local MAX_FILESIZE = 1000 * 1024 -- 1 MB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size < MAX_FILESIZE then
            require("decisive").align_csv({})
        end
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = defaults,
    callback = function() vim.highlight.on_yank() end,
})

autocmd("DirChanged", {
    desc = "Reload .nvim.lua when changing directory",
    callback = function(args)
        local contents = vim.secure.read(string.format("%s/.nvim.lua", args.file))
        if contents then
            assert(loadstring(contents))()
        end
    end,
})

autocmd("FileType", {
    desc = "Enable Spellchecker",
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
                buffer = ev.buf,
                group = augroup("codelens", { clear = false }),
                callback = function() lsp.codelens.refresh({ bufnr = ev.buf }) end,
            })
        end

        -- Mappings
        keymap({ "n", "i" }, "<C-h>", lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

        keymap(
            "n",
            "<A-h>",
            function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf }) end,
            { buffer = ev.buf, desc = "Toggle Hints" }
        )

        keymap({ "n", "x" }, "<leader>la", lsp.buf.code_action, { buffer = ev.buf, desc = "LSP Actions" })
        keymap("n", "<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "LSP Lens" })

        -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
        -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "Go to Definition" })
        -- Similarly with LSP references, which is now mapped by default
        keymap("n", "grr", "<CMD>Telescope lsp_references<CR>", { buffer = ev.buf, desc = "Find References" })
    end,
})
