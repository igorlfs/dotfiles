local status, statuscol = pcall(require, "statuscol")

if not status then
    vim.notify("statuscol not found")
    return
end

local builtin = require("statuscol.builtin")

statuscol.setup({
    relculright = true,
    segments = {
        {
            sign = {
                name = {
                    "Dap",
                    "neotest",
                    "Diagnostic",
                },
                maxwidth = 1,
                colwidth = 1,
                auto = false,
            },
            click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
            sign = {
                name = { "GitSigns" },
                maxwidth = 1,
                colwidth = 1,
                auto = false,
                fillcharhl = "StatusColumnSeparator",
            },
            click = "v:lua.ScSa",
        },
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
