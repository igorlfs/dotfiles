local util = require("util")

local keymap = util.keymap
local feedkeys = util.feedkeys
local pumvisible = util.pumvisible

keymap("<Tab>", function()
    if pumvisible() then
        feedkeys("<C-n>")
    else
        feedkeys("<Tab>")
    end
end, {}, "i")

keymap("<S-Tab>", function()
    if pumvisible() then
        feedkeys("<C-p>")
    else
        feedkeys("<S-Tab>")
    end
end, {}, "i")
