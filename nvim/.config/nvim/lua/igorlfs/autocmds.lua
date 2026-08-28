local cmd = vim.cmd
local api = vim.api
local uv = vim.uv

api.nvim_create_autocmd("FileType", {
    desc = "Enable Softwrap",
    pattern = { "tex", "octo", "typst", "markdown", "liquid" },
    callback = function()
        vim.wo[0][0].wrap = true
    end,
})

-- See https://github.com/neovim/neovim/pull/31443#issuecomment-2521958704
api.nvim_create_autocmd("TermOpen", {
    desc = "Disable scrolloff for terminal",
    callback = function()
        vim.wo[0][0].scrolloff = 0
    end,
})

-- From https://github.com/neovim/neovim/pull/30164#issuecomment-2315421660
api.nvim_create_autocmd("FileType", {
    desc = "Enable Treesitter",
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            return
        end

        vim.wo[0][0].foldexpr = vim.treesitter.foldexpr
    end,
})

api.nvim_create_autocmd({ "TermRequest", "ModeChanged" }, {
    desc = "Refresh tabline",
    callback = function()
        cmd.redrawtabline()
    end,
})

api.nvim_create_autocmd("User", {
    desc = "Refresh statusline",
    pattern = { "DapProgressUpdate", "GitSignsUpdate" },
    callback = function()
        cmd.redrawstatus()
    end,
})

api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
    desc = "Highlight after operation",
    callback = function(args)
        vim.hl.hl_op({ higroup = args.event == "TextPutPost" and "Visual" })
    end,
})

-- From https://github.com/neovim/neovim/issues/27489
api.nvim_create_autocmd("DirChanged", {
    desc = "Reload .nvim.lua when changing directory",
    callback = function(args)
        local contents = vim.secure.read(string.format("%s/.nvim.lua", args.file))
        if type(contents) == "string" then
            assert(loadstring(contents))()
        end
    end,
})

api.nvim_create_autocmd("DirChanged", {
    desc = "Increase zoxide score when changing directory",
    callback = function(args)
        vim.system({ "zoxide", "add", "--", args.file })
    end,
})

api.nvim_create_autocmd("TermRequest", {
    desc = "Manipulates 'path' option on dir change",
    callback = function(ev)
        local dir, n = string.gsub(ev.data.sequence, "\027]7;file://[^/]*", "")
        local stat = uv.fs_stat(dir)
        if n > 0 and stat and stat.type == "directory" and api.nvim_get_current_buf() == ev.buf then
            if vim.b[ev.buf].osc7_dir then
                cmd("setlocal path-=" .. vim.b[ev.buf].osc7_dir)
            end
            cmd("setlocal path+=" .. dir)
            vim.b[ev.buf].osc7_dir = dir
        end
    end,
})

api.nvim_create_autocmd("OptionSet", {
    desc = "Reset statuscolumn for terminal buffers",
    pattern = "buftype",
    callback = function()
        if vim.v.option_new == "terminal" then
            vim.wo[0][0].statuscolumn = ""
        end
    end,
})

api.nvim_create_autocmd("BufWinEnter", {
    desc = "Reset statuscolumn for miscellaneous buffers",
    callback = function()
        local disabled_buftype = vim.tbl_contains({ "nofile", "help", "prompt" }, vim.bo[0].buftype)
        -- See https://github.com/NeogitOrg/neogit/commit/e74dfb42c04b493031f323aec8fa5f28b0427b9e
        local disabled_filetype = vim.bo[0].filetype == "gitcommit"

        if disabled_buftype or disabled_filetype then
            vim.wo[0][0].statuscolumn = ""
        end
    end,
})

api.nvim_create_autocmd("FileType", {
    desc = "Enable Spellchecker",
    pattern = { "gitcommit", "tex", "octo", "typst" },
    callback = function()
        vim.wo[0][0].spell = true
    end,
})

api.nvim_create_autocmd("LspAttach", {
    desc = "LSP",
    callback = function(args)
        local lsp = vim.lsp
        local buf = args.buf
        local client = lsp.get_client_by_id(args.data.client_id)

        -- We are attaching, the client should always exist
        assert(client ~= nil, "Has LSP client")

        if client:supports_method("textDocument/documentHighlight") then
            api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
                buffer = buf,
                callback = lsp.buf.document_highlight,
            })
            api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                buffer = buf,
                callback = lsp.buf.clear_references,
            })
        end

        require("igorlfs.util").lsp_auto_format(client, buf)

        vim.keymap.set("n", "<A-h>", function()
            lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
        end, { buf = buf, desc = "Toggle Hints" })
    end,
})

api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local value = ev.data.params.value or {}
        local msg = value.message or "done"

        api.nvim_echo({ { msg } }, false, {
            id = "lsp",
            kind = "progress",
            source = "vim.lsp",
            title = value.title,
            status = value.kind ~= "end" and "running" or "success",
            percent = value.percentage,
        })
    end,
})
