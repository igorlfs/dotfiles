return {
    "mfussenegger/nvim-dap",
    dependencies = {
    },
    keys = function()
        local dap = require("dap")
        return {
            { "[f", dap.up, desc = "DAP Up" },
            { "]f", dap.down, desc = "DAP Down" },
            { "<F1>", require("dap.ui.widgets").hover, desc = "DAP Hover", mode = { "n", "v" } },
            { "<F4>", function() dap.terminate({ hierarchy = true }) end, desc = "DAP Terminate" },
            { "<F5>", dap.continue, desc = "DAP Continue" },
            {
                "<F8>",
                function()
                    vim.ui.input(
                        { prompt = "Log point message: " },
                        function(input) dap.set_breakpoint(nil, nil, input) end
                    )
                end,
                desc = "Toggle Logpoint",
            },
            { "<F9>", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
            { "<F10>", dap.step_over, desc = "Step Over" },
            { "<F11>", dap.step_into, desc = "Step Into" },
            { "<F12>", dap.step_out, desc = "Step Out" },
            { "<F17>", dap.run_last, desc = "Run Last" },
            { "<F18>", dap.run_to_cursor, desc = "Run to Cursor" },
            {
                "<F21>",
                function()
                    vim.ui.input(
                        { prompt = "Breakpoint condition: " },
                        function(input) dap.set_breakpoint(input) end
                    )
                end,
                desc = "Conditional Breakpoint",
            },
        }
    end,
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
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "debugPC" })

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
        -- Python
        require("plugins.dap.debugpy")
        -- JS, TS
        require("plugins.dap.js-debug-adapter")
    end,
}
