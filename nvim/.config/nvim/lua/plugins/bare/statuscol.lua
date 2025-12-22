return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")

        local modifiable = function(args) return vim.bo[args.buf].modifiable end

        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    sign = { name = { "Dap" } },
                    condition = { modifiable },
                },
                {
                    text = { builtin.lnumfunc, " " },
                    condition = { modifiable, modifiable },
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
                -- Handles kulala's filetypes (and likely others I also wanna ignore)
                "nofile",
            },
        })
    end,
}
