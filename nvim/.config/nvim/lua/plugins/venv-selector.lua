return {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "VenvSelect",
    config = function()
        require("venv-selector").setup()
        vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
            desc = "Venv autoselect",
            pattern = "*",
            callback = function()
                if vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";") ~= "" then
                    require("venv-selector").retrieve_from_cache()
                end
            end,
            once = true,
        })
    end,
}
