-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
	hl.exec_cmd("gammastep -l -19.5:-43.6 -t 6500K:3500K")
	hl.exec_cmd("hypridle")
end)

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-light")
hl.env("HYPRCURSOR_SIZE", 32)

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	input = {
		kb_layout = "br",
		scroll_method = "edge",
		touchpad = {
			middle_button_emulation = true,
		},
	},
	cursor = {
		inactive_timeout = 5,
		hide_on_key_press = true,
		no_warps = true,
	},
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 2,
		col = {
			active_border = "rgb(cdd6f4)",
			inactive_border = "rgb(1e1e2e)",
		},
		-- TODO test "scrolling"
		layout = "master",
	},
	animations = {
		enabled = false,
	},
	misc = {
		disable_splash_rendering = true,
		disable_hyprland_logo = true,
		background_color = "rgba(1e1e2eff)",
	},
})

require(".window-rules")
require(".keybindings")
