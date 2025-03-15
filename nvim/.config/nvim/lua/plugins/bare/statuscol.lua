return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                { sign = { name = { "Dap" } } },
                { text = { builtin.lnumfunc, " " } },
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
            },
        })
    end,
}
