return {
    "pwntester/octo.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "ibhagwan/fzf-lua",
    },
    cmd = "Octo",
    opts = {
        picker = "fzf-lua",
        reviews = {
            auto_show_threads = false,
        },
    },
    keys = {
        { "<leader>op", "<CMD>Octo pr list<CR>", desc = "GH PR" },
    },
    init = function() vim.treesitter.language.register("markdown", "octo") end,
}
