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
        },
        typescript = {
            inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
    },
}
