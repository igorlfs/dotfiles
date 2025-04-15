return {
    on_attach = function(client, _)
        -- Workaround to trigger reloading JS/TS files
        -- See https://github.com/sveltejs/language-tools/issues/2008
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
            callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
        })
    end,
    settings = {
        typescript = {
            inlayHints = {
                parameterNames = {
                    enabled = "literals",
                    suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
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
