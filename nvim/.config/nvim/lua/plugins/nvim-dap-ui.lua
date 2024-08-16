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
                elements = { "console", "watches" },
                position = "bottom",
                size = 15,
            },
        },
        expand_lines = false,
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
        { "<A-p>", function() require("dapui").toggle({ reset = true }) end, desc = "Toggle DAP UI" },
    },
}
