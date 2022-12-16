local nt = require("neotest")

-- setup
nt.setup({
    adapters = {
        require("neotest-python")({
            args = { "-v" }, -- get more diff
        }),
    },
    output = {
        -- disable pop-up with failing test info
        -- prefer virtual text instead
        open_on_run = false,
    },
})

-- keymaps
local keymap = vim.keymap.set

-- Test All
keymap("n", "<leader>ta", function()
    nt.run.run(vim.fn.getcwd())
end)
-- Test Nearest
keymap("n", "<leader>tn", nt.run.run)
-- Test File
keymap("n", "<leader>tf", function()
    nt.run.run(vim.fn.expand("%"))
end)
-- Test Debug
keymap("n", "<leader>td", function()
    nt.run.run({ strategy = "dap" })
end)
-- Test Summary
keymap("n", "<leader>ts", function()
    nt.summary.toggle()
end)
