return {
    "mhartington/formatter.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local types = "formatter.filetypes."
        require("formatter").setup({
            filetype = {
                sh = {
                    require(types .. "sh").shfmt,
                },
                lua = {
                    require(types .. "lua").stylua,
                },
                python = {
                    require(types .. "python").black,
                    require(types .. "python").isort,
                },
                markdown = {
                    function()
                        return {
                            exe = "cbfmt",
                            args = {
                                "--config",
                                vim.fn.stdpath("config") .. "/cbfmt.toml",
                                "--parser",
                                "markdown",
                            },
                            stdin = true,
                        }
                    end,
                },
            },
        })
    end,
}
