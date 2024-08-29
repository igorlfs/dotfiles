return {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    keys = {
        { "<A-o>", "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview", ft = "markdown" },
    },
}
