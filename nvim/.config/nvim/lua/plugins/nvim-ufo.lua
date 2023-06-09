return {
    -- LSP Extension: textDocument/foldingRange (lineFoldingOnly)
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    keys = {
        -- Don't change fold level when opening and closing all folds
        {
            "zR",
            function()
                require("ufo").openAllFolds()
                vim.cmd("IndentBlanklineRefresh")
            end,
            desc = "Open All Folds",
        },
        {
            "zM",
            function()
                require("ufo").closeAllFolds()
                vim.cmd("IndentBlanklineRefresh")
            end,
            desc = "Open All Folds",
        },
    },
    config = function()
        require("ufo").setup()
    end,
}
