return {
    -- LSP Extension: textDocument/foldingRange (lineFoldingOnly)
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    opts = {
        provider_selector = function(_, filetype, _)
            -- Languages whose LSP doesn't support folding
            -- and treesitter support for folds is fine
            -- as of 06/23, markdown's treesitter isn't that great
            local excluded = { "cpp", "c", "julia", "lua" }
            if vim.tbl_contains(excluded, filetype) then
                return { "treesitter", "indent" }
            end
            return { "lsp", "indent" }
        end,
    },
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
}
