local wezterm = require("wezterm")

local config = {}

-- Provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Cursor
config.force_reverse_video_cursor = true

-- Font
config.font = wezterm.font("Iosevka NF")
config.font_size = 10.5

-- Remove extra space
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Changing the color scheme:
config.color_scheme = "catppuccin-mocha"

-- Support for undercurl, etc
config.term = "wezterm"

-- Disable tabbar
config.enable_tab_bar = false

return config
