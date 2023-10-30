return {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "javascript" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        settings = {
            separate_diagnostic_server = false,
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
            },
        },
    },
}
