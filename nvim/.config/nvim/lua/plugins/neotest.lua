local status, neotest = pcall(require, "neotest")

if not status then
    vim.notify("neotest not found")
    return
end

neotest.setup({
    adapters = {
        require("neotest-python")({
            args = { "-v" }, -- get more diff
        }),
        require("neotest-rust"),
        require("neotest-jest"),
        require("neotest-java"),
    },
    output = {
        -- disable pop-up with failing test info
        -- prefer virtual text instead
        open_on_run = false,
    },
})

-- Keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>tn", neotest.run.run, { desc = "Test Nearest" })
keymap("n", "<leader>ts", neotest.summary.toggle, { desc = "Test Summary" })
keymap("n", "<leader>ta", function()
    neotest.run.run(vim.fn.getcwd())
end, { desc = "Test All" })
keymap("n", "<leader>tf", function()
    neotest.run.run(vim.fn.expand("%"))
end, { desc = "Test File" })
keymap("n", "<leader>dt", function()
    neotest.run.run({ strategy = "dap" })
end, { desc = "Debug Test" })
