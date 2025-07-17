local shared = require("shared")

---@type vim.lsp.Config
return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "typescript-svelte-plugin",
                        location = "/usr/lib/node_modules",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
            -- Improve completion performance,
            -- see https://github.com/yioneko/vtsls?tab=readme-ov-file#bad-performance-of-completion
            -- To be fair, I don't think it's that bad, but enabling this setting is harmless
            experimental = {
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
        },
        typescript = {
            inlayHints = shared.ts_ls_inlay_hint_setup,
        },
    },
}
