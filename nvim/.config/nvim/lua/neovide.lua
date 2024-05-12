local g = vim.g

g.neovide_remember_window_size = false -- Disable Neovide's fullscreen by default
g.neovide_scroll_animation_length = 0.2 -- Slightly faster scroll animation
g.neovide_hide_mouse_when_typing = true

g.neovide_scale_factor = 1.0

---@param delta number
local change_scale_factor = function(delta) g.neovide_scale_factor = g.neovide_scale_factor * delta end

------ Keymaps
local keymap = vim.keymap.set
local str = string.format
-- Zoom
keymap("n", "<C-=>", function() change_scale_factor(1.25) end, { desc = "Zoom-in Neovide" })
keymap("n", "<C-->", function() change_scale_factor(1 / 1.25) end, { desc = "Zoom-out Neovide" })
-- Function Keys
-- See neovide#2520
for i = 1, 9 do
    keymap("n", str("<S-F%s>", i), str("<F%s>", i + 12), { desc = str("Shifted Function Key %s", i), remap = true })
end
