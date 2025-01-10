return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                -- Enable additional capabilities nvim-cmp provides for completion
                require("cmp_nvim_lsp").default_capabilities(),
                -- Enable additional capabilities for fileOperations just in case a server needs it
                require("lsp-file-operations").default_capabilities()
            ),
        })

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
            lspconfig[lsp].setup({})
        end

        require("plugins.lsp.clangd")
        require("plugins.lsp.jsonls")
        require("plugins.lsp.lua_ls")
        require("plugins.lsp.svelte")
        require("plugins.lsp.tinymist")
        require("plugins.lsp.vtsls")
    end,
}
