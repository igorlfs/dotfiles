local keymap = require("util").keymap
local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    desc = "LSP",
    callback = function(args)
        local lsp = vim.lsp
        local buf = args.buf
        local client = lsp.get_client_by_id(args.data.client_id)
        local methods = lsp.protocol.Methods

        lsp.on_type_formatting.enable()
        lsp.linked_editing_range.enable(true, nil)

        if client and client:supports_method(methods.textDocument_documentHighlight) then
            autocmd({ "CursorHold", "InsertLeave" }, {
                buffer = buf,
                callback = lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                buffer = buf,
                callback = lsp.buf.clear_references,
            })
        end

        -- Code Lenses
        keymap("<leader>ll", lsp.codelens.run, { buffer = buf, desc = "LSP Lens" })
        if client and client:supports_method(methods.textDocument_codeLens) then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = buf,
                callback = function() lsp.codelens.refresh({ bufnr = buf }) end,
            })
        end

        keymap(
            "<A-h>",
            function()
                lsp.inlay_hint.enable(
                    not lsp.inlay_hint.is_enabled({ bufnr = buf }),
                    { bufnr = buf }
                )
            end,
            { buffer = buf, desc = "Toggle Hints" }
        )
    end,
})
