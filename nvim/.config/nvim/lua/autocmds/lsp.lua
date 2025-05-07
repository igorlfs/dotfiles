local keymap = require("util").keymap
local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    desc = "LSP",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local lsp = vim.lsp
        local methods = lsp.protocol.Methods

        vim.lsp.document_color.enable(true, args.buf)

        if client and client:supports_method(methods.textDocument_documentHighlight) then
            autocmd({ "CursorHold", "InsertLeave" }, {
                buffer = args.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                buffer = args.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Code Lenses
        keymap("<leader>ll", lsp.codelens.run, { buffer = args.buf, desc = "LSP Lens" })
        if client and client:supports_method(methods.textDocument_codeLens) then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = args.buf,
                callback = function() lsp.codelens.refresh({ bufnr = args.buf }) end,
            })
        end

        keymap(
            "<A-h>",
            function()
                lsp.inlay_hint.enable(
                    not lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
                    { bufnr = args.buf }
                )
            end,
            { buffer = args.buf, desc = "Toggle Hints" }
        )
    end,
})
