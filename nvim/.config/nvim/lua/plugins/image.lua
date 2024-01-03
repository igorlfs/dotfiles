return {
    "3rd/image.nvim",
    enabled = false,
    opts = {
        backend = "kitty",
        max_width = 100,
        max_height = 20,
        -- markdown integration is kinda wonky
        integrations = {
            markdown = {
                enabled = false,
            },
        },
        -- molten recommends these settings
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
    },
    init = function()
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
    end,
}
