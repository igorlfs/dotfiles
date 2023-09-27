return {
    "mfussenegger/nvim-lint",
    event = "BufWritePre",
    config = function()
        require("lint").linters_by_ft = {
            gdscript = { "gdlint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function() require("lint").try_lint() end,
        })
    end,
}
