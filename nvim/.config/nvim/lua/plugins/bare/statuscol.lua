return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")

        local eligible = function(args)
            local buf = vim.bo[args.buf]
            local win = vim.wo[args.win]

            return buf.modifiable or win.diff
        end

        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    sign = { name = { "Dap" } },
                    condition = { eligible },
                },
                {
                    text = { builtin.lnumfunc, " " },
                    condition = { eligible, eligible },
                },
                { sign = { namespace = { "gitsigns" }, wrap = true } },
            },
            ft_ignore = {
                "NvimTree",
                "NeogitStatus",
                "NeogitPopup",
                "NeogitCommitMessage",
                "NeogitCommitView",
                "dap-repl",
            },
            bt_ignore = {
                "terminal",
                "quickfix",
                -- Handles kulala's filetypes (and likely others I also wanna ignore)
                "nofile",
            },
        })
    end,
}
