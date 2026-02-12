return {
    "neovim/nvim-lspconfig",
    config = function()
        for _, language_server in ipairs({
            "biome",
            "cssls",
            "dotls",
            "html",
            "hyprls",
            "jsonls",
            "lua_ls",
            "postgres_lsp",
            "ruff",
            "svelte",
            "tailwindcss",
            "taplo",
            "tinymist",
            "ts_query_ls",
            "ty",
            "yamlls",
        }) do
            vim.lsp.enable(language_server)
        end
    end,
}
