_G.emmy = {}

local mise_path = "/mise/installs/github-emmy-lua-emmy-lua-debugger/latest/?.so"
local path_to_emmy_core = vim.fn.expand("$XDG_DATA_HOME") .. mise_path

require("igorlfs.util").keymap("<leader><leader>", function()
    if string.match(package.cpath, path_to_emmy_core) then
        return
    end

    package.cpath = package.cpath .. ";" .. path_to_emmy_core

    -- See https://github.com/EmmyLuaLs/emmylua_dap/issues/2
    ---@param oldPath string
    ---@return string?
    function _G.emmy.fixPath(oldPath)
        return vim.uv.fs_realpath(oldPath)
    end

    require("emmy_core").tcpListen("localhost", 9966)
end, "Debug Lua")
