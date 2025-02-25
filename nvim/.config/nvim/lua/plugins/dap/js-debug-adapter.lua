local dap = require("dap")

for _, adapter in pairs({ "node", "chrome" }) do
    local pwa_adapter = "pwa-" .. adapter

    dap.adapters[pwa_adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
        },
    }

    -- This allow us to handle launch.json configurations
    -- which specify type as "node" or "chrome"
    -- Courtesy of https://github.com/StevanFreeborn/nvim-config/blob/main/lua/plugins/debugging.lua#L111-L123
    dap.adapters[adapter] = function(callback, config)
        local native_adapter = dap.adapters[pwa_adapter]

        config.type = pwa_adapter

        -- We just defined the pwa_adapter above, it's not a function
        assert(type(native_adapter) ~= "function")

        callback(native_adapter)
    end
end
