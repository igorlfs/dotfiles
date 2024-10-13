local keymap = require("util").keymap

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP",
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local lsp = vim.lsp
        local methods = lsp.protocol.Methods

        -- Lenses
        if client and client.supports_method(methods.textDocument_codeLens) then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = ev.buf,
                callback = function() lsp.codelens.refresh({ bufnr = ev.buf }) end,
            })
        end

        -- Mappings
        keymap(
            "<C-h>",
            lsp.buf.signature_help,
            { buffer = ev.buf, desc = "Signature Help" },
            { "n", "i" }
        )

        keymap(
            "<A-h>",
            function()
                lsp.inlay_hint.enable(
                    not lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
                    { bufnr = ev.buf }
                )
            end,
            { buffer = ev.buf, desc = "Toggle Hints" }
        )

        keymap("<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "LSP Lens" })
    end,
})
