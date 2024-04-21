return {
    -- LSP Extension: textDocument/foldingRange (lineFoldingOnly)
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {
        provider_selector = function(_, filetype, _)
            -- Languages that support LSP folding
            local foldable = { "rust", "typescript" }
            if vim.tbl_contains(foldable, filetype) then
                return { "lsp", "indent" }
            end
            return { "treesitter", "indent" }
        end,
    },
    keys = {
        -- Don't change fold level when opening and closing all folds
        {
            "zR",
            function() require("ufo").openAllFolds() end,
            desc = "Open All Folds",
        },
        {
            "zM",
            function() require("ufo").closeAllFolds() end,
            desc = "Close All Folds",
        },
    },
}
