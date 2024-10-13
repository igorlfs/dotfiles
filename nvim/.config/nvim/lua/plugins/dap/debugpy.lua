require("dap").adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "localhost"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
        })
    else
        cb({
            type = "executable",
            command = "debugpy-adapter",
        })
    end
end

-- The python adapter is deprecated, see nvim-dap-python#129
require("dap").adapters.debugpy = require("dap").adapters.python
