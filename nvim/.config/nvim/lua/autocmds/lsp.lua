local keymap = require("util").keymap

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP",
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local lsp = vim.lsp
        local methods = lsp.protocol.Methods

        -- Folds
        vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"

        -- Code Lenses
        keymap("<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "LSP Lens" })
        if client and client:supports_method(methods.textDocument_codeLens) then
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = ev.buf,
                callback = function() lsp.codelens.refresh({ bufnr = ev.buf }) end,
            })
        end

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
    end,
})
