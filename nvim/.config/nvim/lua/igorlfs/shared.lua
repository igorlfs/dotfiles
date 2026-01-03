local M = {}

M.ts_ls_inlay_hint_setup = {
    parameterNames = {
        enabled = "literals",
        suppressWhenArgumentMatchesName = true,
    },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
}

return M
