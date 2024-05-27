return {
    "rcarriga/nvim-dap-ui",
    dependencies = "nvim-neotest/nvim-nio",
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
}
