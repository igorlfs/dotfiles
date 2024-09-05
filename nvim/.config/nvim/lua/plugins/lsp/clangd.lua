require("lspconfig").clangd.setup({
    cmd = { "clangd", "--completion-style=detailed" },
    on_attach = function()
        vim.keymap.set("n", "<A-o>", "<CMD>ClangdSwitchSourceHeader<CR>", { buffer = 0 })
    end,
})
