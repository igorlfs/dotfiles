return {
    "b0o/schemastore.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        local schemastore = require("schemastore")
        local lspconfig = require("lspconfig")
        -- JSON
        lspconfig.jsonls.setup({
            capabilities = require("util").capabilities,
            settings = {
                json = {
                    schemas = schemastore.json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        -- YAML
        lspconfig.yamlls.setup({
            capabilities = require("util").capabilities,
            settings = {
                yaml = {
                    schemas = schemastore.yaml.schemas(),
                },
            },
        })
    end,
}
