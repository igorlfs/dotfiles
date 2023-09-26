return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Runs preLaunchTasks if present
        "stevearc/overseer.nvim",
        { "LiadOz/nvim-dap-repl-highlights", config = true },
        {
            "mfussenegger/nvim-dap-python",
            config = function() require("dap-python").setup("/usr/bin/python") end,
        },
        { "theHamsta/nvim-dap-virtual-text", opts = { enabled = false } },
    },
    keys = {
        { "<F4>", function() require("dap").terminate() end, desc = "DAP Terminate" },
        {
            "<F5>",
            function()
                -- (Re-)reads launch.json if present
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
                end
                require("dap").continue()
            end,
            desc = "DAP Continue",
        },
        { "<F17>", function() require("dap").run_last() end, desc = "Run Last" },
        { "<F6>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<F7>", function() require("dap").goto_() end, desc = "Go to line (skip)" },
        {
            "<F8>",
            function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
            desc = "Breakpoint Condition",
        },
        { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
    config = function()
        local dap = require("dap")

        -- Signs
        local sign = vim.fn.sign_define
        sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })

        -- Adapters
        -- C, C++
        dap.adapters.codelldb = require("util").codelldb
        -- JS, TS
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "js-debug-adapter",
                args = { "${port}" },
            },
        }
        -- Godot
        dap.adapters.godot = {
            type = "server",
            host = "127.0.0.1",
            port = 6006,
        }
        dap.configurations.gdscript = {
            {
                type = "godot",
                request = "launch",
                name = "Launch Scene",
                project = "${workspaceFolder}",
                launch_scene = true,
            },
        }

        local ui = require("dapui")

        -- Hooks
        -- Open and close UI's windows automatically
        dap.listeners.after.event_initialized["dapui_config"] = function() ui.open({ reset = true }) end
        dap.listeners.before.event_terminated["dapui_config"] = function() ui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() ui.close() end
    end,
}
