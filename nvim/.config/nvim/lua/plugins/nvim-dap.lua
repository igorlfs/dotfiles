return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Runs preLaunchTask / postDebugTask if present
        { "stevearc/overseer.nvim", config = true },
        "rcarriga/nvim-dap-ui",
    },
    keys = {
        {
            "<leader>db",
            function() require("dap").list_breakpoints() end,
            desc = "DAP Breakpoints",
        },
        {
            "<leader>ds",
            function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes, { border = "rounded" })
            end,
            desc = "DAP Scopes",
        },
        { "<F1>", function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end },
        { "<F4>", "<CMD>DapDisconnect<CR>", desc = "DAP Disconnect" },
        { "<F16>", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
        { "<F5>", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
        { "<F17>", function() require("dap").run_last() end, desc = "Run Last" },
        { "<F6>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<F9>", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
        {
            "<F21>",
            function()
                vim.ui.input(
                    { prompt = "Breakpoint condition: " },
                    function(input) require("dap").set_breakpoint(input) end
                )
            end,
            desc = "Conditional Breakpoint",
        },
        { "<F10>", "<CMD>DapStepOver<CR>", desc = "Step Over" },
        { "<F11>", "<CMD>DapStepInto<CR>", desc = "Step Into" },
        { "<F12>", "<CMD>DapStepOut<CR>", desc = "Step Out" },
    },
    config = function()
        -- Signs
        for _, group in pairs({
            "DapBreakpoint",
            "DapBreakpointCondition",
            "DapBreakpointRejected",
            "DapLogPoint",
        }) do
            vim.fn.sign_define(group, { text = "●", texthl = group })
        end

        -- Setup

        -- Decides when and how to jump when stopping at a breakpoint
        -- The order matters!
        --
        -- (1) If the line with the breakpoint is visible, don't jump at all
        -- (2) If the buffer is opened in a tab, jump to it instead
        -- (3) Else, create a new tab with the buffer
        --
        -- This avoid unnecessary jumps
        require("dap").defaults.fallback.switchbuf = "usevisible,usetab,newtab"

        -- Adapters
        -- C, C++, Rust
        require("plugins.dap.codelldb")
        -- Python
        require("plugins.dap.debugpy")
        -- JS, TS
        require("plugins.dap.js-debug-adapter")
    end,
}
