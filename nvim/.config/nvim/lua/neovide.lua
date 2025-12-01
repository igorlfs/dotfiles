local g = vim.g

g.neovide_scroll_animation_length = 0.2 -- Slightly faster scroll animation
g.neovide_hide_mouse_when_typing = true

g.neovide_scale_factor = 1.0

---@param delta number
local change_scale_factor = function(delta) g.neovide_scale_factor = g.neovide_scale_factor * delta end

------ Keymaps
local keymap = require("igorlfs.util").keymap
local SCALE_FACTOR = 1.1
-- Zoom
keymap("<C-=>", function() change_scale_factor(SCALE_FACTOR) end, "Zoom-in Neovide")
keymap("<C-->", function() change_scale_factor(1 / SCALE_FACTOR) end, "Zoom-out Neovide")
