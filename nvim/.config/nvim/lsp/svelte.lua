local shared = require("shared")

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
        typescript = shared.ts_ls_inlay_hint_setup,
        svelte = {
            plugin = {
                svelte = {
                    compilerWarnings = {
                        ["a11y-click-events-have-key-events"] = "ignore",
                        ["a11y-no-static-element-interactions"] = "ignore",
                    },
                },
            },
        },
    },
}
