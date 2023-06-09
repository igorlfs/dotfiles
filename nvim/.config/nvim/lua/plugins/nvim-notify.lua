return {
    "rcarriga/nvim-notify",
    opts = {
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    },
    keys = {
        {
            "<leader>n",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss all Notifications",
        },
    },
}
