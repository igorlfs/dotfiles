return {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    opts = {
        icons = {
            expanded = "󰅀",
            collapsed = "󰅂",
            current_frame = "󰅂",
        },
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.5 },
                    { id = "watches", size = 0.5 },
                },
                size = 40,
                position = "left",
            },
            {
                elements = { "console" },
                position = "bottom",
                size = 15,
            },
        },
        controls = {
            enabled = false,
        },
        floating = {
            border = "rounded",
        },
        render = {
            indent = 2,
            -- Hide variable types as C++'s are verbose
            max_type_length = 0,
        },
    },
    keys = {
        { "<F1>", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        { "<F2>", function() require("dapui").eval() end, desc = "DAP Eval" },
        { "<F3>", function() require("dapui").float_element("breakpoints") end, desc = "DAP List Breakpoints" },
    },
    config = function(_, opts)
        local dap, dapui = require("dap"), require("dapui")

        -- Open and Close windows automatically
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        dapui.setup(opts)
    end,
}
