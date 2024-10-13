for _, adapter in pairs({ "pwa-node", "pwa-chrome" }) do
    require("dap").adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
        },
    }
end
