return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Runs preLaunchTasks if present
        "stevearc/overseer.nvim",
    },
    keys = {
        { "<F4>", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
        {
            "<F5>",
            function()
                -- (Re-)reads launch.json if present
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("dap.ext.vscode").load_launchjs(nil, {
                        ["codelldb"] = { "c", "cpp" },
                        ["pwa-node"] = { "typescript", "javascript" },
                    })
                end
                require("dap").continue()
            end,
            desc = "DAP Continue",
        },
        { "<F17>", function() require("dap").run_last() end, desc = "Run Last" },
        { "<F6>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<F7>", function() require("dap").goto_() end, desc = "Go to line (skip)" },
        { "<F9>", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
        {
            "<F21>",
            function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
            desc = "Breakpoint Condition",
        },
        { "<F10>", "<CMD>DapStepOver<CR>", desc = "Step Over" },
        { "<F11>", "<CMD>DapStepInto<CR>", desc = "Step Into" },
        { "<F12>", "<CMD>DapStepOut<CR>", desc = "Step Out" },
    },
    config = function()
        -- Signs
        local sign = vim.fn.sign_define

        local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
        for _, group in pairs(dap_round_groups) do
            sign(group, { text = "●", texthl = group })
        end

        sign("DapStopped", { text = "", texthl = "DapStopped" })

        local dap = require("dap")

        -- Adapters
        -- C, C++
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }
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

        -- Configurations
        -- Usually prefer setting up via launch.json
        -- Godot
        dap.configurations.gdscript = {
            {
                type = "godot",
                request = "launch",
                name = "Launch Scene",
                project = "${workspaceFolder}",
                launch_scene = true,
            },
        }
    end,
}
