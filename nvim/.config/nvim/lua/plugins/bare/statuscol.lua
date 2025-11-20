return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")

        local not_help = function(args) return vim.bo[args.buf].ft ~= "help" end

        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    sign = { name = { "Dap" } },
                    condition = { not_help },
                },
                {
                    text = { builtin.lnumfunc, " " },
                    condition = { not_help, not_help },
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
                -- Handless kulala's filetypes (and likely other I also wanna ignore)
                "nofile",
            },
        })
    end,
}
