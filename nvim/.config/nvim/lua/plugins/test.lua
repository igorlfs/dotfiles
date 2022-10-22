local nt = require("neotest")

-- setup
nt.setup({
    adapters = {
        require("neotest-python"),
    },
})

-- keymaps
local keymap = vim.keymap.set

-- TesT all
keymap("n", "<leader>tt", function()
    nt.run.run(vim.fn.getcwd())
end)
-- Test Nearest
keymap("n", "<leader>tn", nt.run.run)
-- Test File
keymap("n", "<leader>tf", function()
    nt.run.run(vim.fn.expand("%"))
end)
-- Debug Test
keymap("n", "<leader>dt", function()
    nt.run.run({ strategy = "dap" })
end)
-- test SUmmary
keymap("n", "<leader>su", function()
    nt.summary.toggle()
end)
