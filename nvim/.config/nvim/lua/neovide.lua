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
local SCALE_FACTOR = 1.1
-- Zoom
keymap("n", "<C-=>", function() change_scale_factor(SCALE_FACTOR) end, { desc = "Zoom-in Neovide" })
keymap(
    "n",
    "<C-->",
    function() change_scale_factor(1 / SCALE_FACTOR) end,
    { desc = "Zoom-out Neovide" }
)
-- Function Keys
-- See neovide#2520
for i = 1, 9 do
    keymap(
        "n",
        str("<S-F%s>", i),
        str("<F%s>", i + 12),
        { desc = str("Shifted Function Key %s", i), remap = true }
    )
end
