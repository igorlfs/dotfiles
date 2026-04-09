local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

local autocmd = api.nvim_create_autocmd

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Reload files if they changed externaly",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            cmd.checktime()
        end
    end,
})

autocmd("FileType", {
    desc = "Enable Softwrap",
    pattern = { "tex", "octo", "typst", "markdown", "liquid" },
    callback = function()
        vim.wo[0][0].wrap = true
    end,
})

-- See https://github.com/neovim/neovim/pull/31443#issuecomment-2521958704
autocmd("TermOpen", {
    desc = "Disable scrolloff for terminal",
    callback = function()
        vim.wo[0][0].scrolloff = 0
    end,
})

-- From https://github.com/neovim/neovim/pull/30164#issuecomment-2315421660
autocmd("FileType", {
    desc = "Enable Treesitter",
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            return
        end

        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})

autocmd({ "TermRequest", "ModeChanged" }, {
    desc = "Refresh tabline",
    callback = function()
        cmd.redrawtabline()
    end,
})

autocmd("User", {
    desc = "Refresh statusline",
    pattern = { "DapProgressUpdate", "GitSignsUpdate" },
    callback = function()
        cmd.redrawstatus()
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- From https://github.com/neovim/neovim/issues/27489
autocmd("DirChanged", {
    desc = "Reload .nvim.lua when changing directory",
    callback = function(args)
        local contents = vim.secure.read(string.format("%s/.nvim.lua", args.file))
        if type(contents) == "string" then
            assert(loadstring(contents))()
        end
    end,
})

autocmd("DirChanged", {
    desc = "Increase zoxide score when changing directory",
    callback = function(args)
        vim.system({ "zoxide", "add", "--", args.file })
    end,
})

autocmd("TermRequest", {
    desc = "Manipulates 'path' option on dir change",
    callback = function(ev)
        local dir, n = string.gsub(ev.data.sequence, "\027]7;file://[^/]*", "")
        if n > 0 and fn.isdirectory(dir) ~= 0 and api.nvim_get_current_buf() == ev.buf then
            if vim.b[ev.buf].osc7_dir then
                cmd("setlocal path-=" .. vim.b[ev.buf].osc7_dir)
            end
            cmd("setlocal path+=" .. dir)
            vim.b[ev.buf].osc7_dir = dir
        end
    end,
})

autocmd("OptionSet", {
    desc = "Reset statuscolumn for terminal buffers",
    pattern = "buftype",
    callback = function()
        if vim.v.option_new == "terminal" then
            vim.wo[0][0].statuscolumn = ""
        end
    end,
})

autocmd("BufWinEnter", {
    desc = "Reset statuscolumn for miscellaneous buffers",
    callback = function()
        if vim.tbl_contains({ "nofile", "help", "prompt" }, vim.bo[0].buftype) then
            vim.wo[0][0].statuscolumn = ""
        end
    end,
})

autocmd("FileType", {
    desc = "Enable Spellchecker",
    pattern = { "gitcommit", "tex", "octo", "typst" },
    callback = function()
        vim.wo[0][0].spell = true
    end,
})

autocmd("FileType", {
    desc = "Reset statuscolumn for Neogit buffers",
    pattern = { "Neogit*" },
    callback = function()
        vim.wo[0][0].statuscolumn = ""
    end,
})

autocmd("LspAttach", {
    desc = "LSP",
    callback = function(args)
        local lsp = vim.lsp
        local buf = args.buf
        local client = lsp.get_client_by_id(args.data.client_id)

        -- We are attaching, the client should always exist
        assert(client ~= nil, "Has LSP client")

        if client:supports_method("textDocument/documentHighlight") then
            autocmd({ "CursorHold", "InsertLeave" }, {
                buffer = buf,
                callback = lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                buffer = buf,
                callback = lsp.buf.clear_references,
            })
        end

        vim.keymap.set("n", "<A-h>", function()
            lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
        end, { buf = buf, desc = "Toggle Hints" })
    end,
})
