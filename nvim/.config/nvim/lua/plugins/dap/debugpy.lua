require("dap").adapters.debugpy = function(cb, config)
    if config.request == "attach" then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or "localhost"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
        })
    else
        cb({
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
        })
    end
end
