local util = require("lspconfig.util")

require("lspconfig").svelte.setup({
    on_attach = function(client, _)
        -- Workaround to trigger reloading JS/TS files
        -- See https://github.com/sveltejs/language-tools/issues/2008
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
            callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
        })
    end,
    -- Respect monorepo's root dir
    -- Won't be upstreamed
    -- See https://github.com/neovim/nvim-lspconfig/pull/3491
    root_dir = util.root_pattern(".git", "package.json"),
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
})
