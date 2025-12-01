local keymap = require("igorlfs.util").keymap
local autocmd = vim.api.nvim_create_autocmd

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

        -- Code Lenses
        keymap("<leader>ll", lsp.codelens.run, { buffer = buf, desc = "LSP Lens" })
        if client:supports_method("textDocument/codeLens") then
            autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = buf,
                callback = function() lsp.codelens.refresh({ bufnr = buf }) end,
            })
        end

        keymap(
            "<A-h>",
            function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf }) end,
            { buffer = buf, desc = "Toggle Hints" }
        )
    end,
})
