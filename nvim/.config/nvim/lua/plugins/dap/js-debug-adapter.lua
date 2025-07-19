local dap = require("dap")

for _, adapter in pairs({ "node", "chrome" }) do
    local pwa_adapter = "pwa-" .. adapter

    -- Handle launch.json configurations
    -- which specify type as "node" or "chrome"
    -- Inspired by https://github.com/StevanFreeborn/nvim-config/blob/main/lua/plugins/debugging.lua#L111-L123

    -- Main adapter
    dap.adapters[pwa_adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
        },
        enrich_config = function(config, on_config)
            -- Under the hood, always use the main adapter
            config.type = pwa_adapter
            on_config(config)
        end,
    }

    -- Dummy adapter, redirects to the main one
    dap.adapters[adapter] = dap.adapters[pwa_adapter]
end
