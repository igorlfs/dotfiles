---@param keys string
---@param dispatcher HL.Dispatcher
---@param opts HL.BindOptions?
local bind = function(keys, dispatcher, opts)
	hl.bind("SUPER" .. keys, dispatcher, opts)
end

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local dsp = hl.dsp
local win = dsp.window

bind(" + F", dsp.exec_cmd("footclient"))
bind(" + S", dsp.exec_cmd("footclient -- nvim"))
bind(" + W", dsp.exec_cmd("firefox"))

bind(" + SHIFT + L", dsp.exec_cmd("hyprlock"))

hl.bind("Print", dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
bind(" + Print", dsp.exec_cmd("grim - | swappy -f -"))

bind("+ ALT_L", dsp.exec_cmd("killall -SIGUSR1 waybar || waybar"))

bind("+ Tab", dsp.focus({ workspace = "prev" }))

for i = 1, 10 do
	local key = i % 10
	bind(" + " .. key, dsp.focus({ workspace = i }))
	bind(" + SHIFT + " .. key, win.move({ workspace = i }))
end

bind(" + mouse:272", win.drag(), { mouse = true })
bind(" + mouse:273", win.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind(
	"SHIFT + XF86AudioRaiseVolume",
	dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"),
	{ repeating = true }
)
hl.bind(
	"SHIFT + XF86AudioLowerVolume",
	dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"),
	{ repeating = true }
)
hl.bind("XF86AudioMute", dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true })

bind(" + H", dsp.focus({ direction = "left" }))
bind(" + L", dsp.focus({ direction = "right" }))
bind(" + K", dsp.focus({ direction = "up" }))
bind(" + J", dsp.focus({ direction = "down" }))
