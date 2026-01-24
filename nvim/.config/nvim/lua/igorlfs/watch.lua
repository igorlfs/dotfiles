-- https://github.com/neovim/neovim/issues/23291#issuecomment-1712422887
local watch_type = require("vim._watch").FileChangeType

local function handler(res, callback)
    if not res.files or res.is_fresh_instance then
        return
    end

    for _, file in ipairs(res.files) do
        local path = res.root .. "/" .. file.name
        local change = watch_type.Changed
        if file.new then
            change = watch_type.Created
        end
        if not file.exists then
            change = watch_type.Deleted
        end
        callback(path, change)
    end
end

local function watchman(path, _, callback)
    vim.system({ "watchman", "watch", path }):wait()

    local buf = {}
    local sub = vim.system({
        "watchman",
        "-j",
        "--server-encoding=json",
        "-p",
    }, {
        stdin = vim.json.encode({
            "subscribe",
            path,
            "nvim:" .. path,
            {
                expression = { "anyof", { "type", "f" }, { "type", "d" } },
                fields = { "name", "exists", "new" },
            },
        }),
        stdout = function(_, data)
            if not data then
                return
            end
            for line in vim.gsplit(data, "\n", { plain = true, trimempty = true }) do
                table.insert(buf, line)
                if line == "}" then
                    local res = vim.json.decode(table.concat(buf))
                    handler(res, callback)
                    buf = {}
                end
            end
        end,
        text = true,
    })

    return function() sub:kill("sigint") end
end

if vim.fn.executable("watchman") == 1 then
    require("vim.lsp._watchfiles")._watchfunc = watchman
end
