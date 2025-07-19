local shared = require("shared")

---@type vim.lsp.Config
return {
    settings = {
        typescript = {
            inlayHints = shared.ts_ls_inlay_hint_setup,
        },
    },
}
