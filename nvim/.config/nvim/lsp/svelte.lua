local shared = require("shared")

---@type vim.lsp.Config
return {
    on_attach = function(client)
        -- Workaround to trigger reloading JS/TS files
        -- See https://github.com/sveltejs/language-tools/issues/2008
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
        })
    end,
    settings = {
        typescript = {
            inlayHints = shared.ts_ls_inlay_hint_setup,
        },
    },
}
