return {
    "pwntester/octo.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Octo",
    config = true,
    init = function()
        vim.treesitter.language.register("markdown", "octo")
    end,
}
