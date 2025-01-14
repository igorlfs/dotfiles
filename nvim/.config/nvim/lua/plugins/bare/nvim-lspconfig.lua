return {
    "neovim/nvim-lspconfig",
    config = function()
        for _, lsp in ipairs({
            "basedpyright",
            "biome",
            "cssls",
            "dockerls",
            "dotls",
            "emmet_language_server",
            "html",
            "ruff",
            "tailwindcss",
            "taplo",
            "yamlls",
        }) do
            require("lspconfig")[lsp].setup({})
        end

        require("plugins.lsp.clangd")
        require("plugins.lsp.jsonls")
        require("plugins.lsp.lua_ls")
        require("plugins.lsp.svelte")
        require("plugins.lsp.tinymist")
        require("plugins.lsp.vtsls")
    end,
}
