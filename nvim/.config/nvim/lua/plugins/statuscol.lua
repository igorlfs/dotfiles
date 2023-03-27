local builtin = require("statuscol.builtin")

require("statuscol").setup({
    segments = {
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    },
    ft_ignore = {
        "NvimTree",
        "packer",
        "NeogitStatus",
        "toggleterm",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
        "dapui_repl",
    },
})
