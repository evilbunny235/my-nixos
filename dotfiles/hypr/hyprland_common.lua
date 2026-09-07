hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XKB_DEFAULT_LAYOUT", "us")
hl.env("XKB_DEFAULT_VARIANT", "dvorak")
hl.env("XKB_DEFAULT_OPTIONS", "caps:escape,altwin:menu_win")
hl.env("EGL_PLATFORM", "wayland")

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dms run")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("udiskie")
end)

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "dvorak",
		kb_options = "caps:escape, altwin:menu_win",
		follow_mouse = 1,
		sensitivity = 0,
	},
	general = {
		layout = "dwindle",
		gaps_in = 1,
		gaps_out = 2,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
				angle = 45,
			},
			inactive_border = "rgba(00000000)",
		},
	},
	decoration = {
		rounding = 8,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 2,
			color = "rgba(66000000)",
		},
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 878.5, dampening = 59.2 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.window_rule({
	match = { float = true },
	border_size = 0,
})

hl.window_rule({
	match = { title = "^Media viewer$" },
	float = true,
})

hl.window_rule({
	match = { title = "^org.pulseaudio.pavucontrol$" },
	size = { 1000, 700 },
	float = true,
})

hl.window_rule({
	match = { class = "^com.saivert.pwvucontrol$" },
	size = { 1000, 700 },
	float = true,
})

hl.window_rule({
	match = { class = "^com.saivert.pwvucontrol$" },
	size = { 1000, 700 },
	float = true,
})

hl.window_rule({
	match = { title = "^Save As$" },
	size = { 1200, 700 },
	float = true,
	center = true,
})

hl.window_rule({
	match = { title = "^File Upload$" },
	size = { 1200, 700 },
	float = true,
	center = true,
})

hl.window_rule({
	match = { title = "^Picture-in-Picture$" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "^.blueman-manager-wrapped$" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "^com.gabm.satty$" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "^firefox$" },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	match = { class = "^vlc$" },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	match = { class = "^org.quickshell$" },
	float = true,
	center = true,
})

hl.bind("SUPER + J", hl.dsp.window.close())
hl.bind("SUPER + K", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + H", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + U", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + N", hl.dsp.focus({ workspace = "empty" }))
hl.bind("SUPER + SHIFT + N", hl.dsp.window.move({ workspace = "empty" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = "-20", y = "0", relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = "20", y = "0", relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = "0", y = "-20", relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = "0", y = "20", relative = true }), { repeating = true })

hl.bind("print", hl.dsp.exec_raw("screenshot_focused_monitor"))
hl.bind("SUPER + print", hl.dsp.exec_raw("screenshot_area"))
hl.bind("SUPER + SHIFT + print", hl.dsp.exec_raw("screenshot_focused_window"))

hl.bind("SUPER + return", hl.dsp.exec_raw("ghostty --working-directory=home"))
hl.bind("SUPER + E", hl.dsp.exec_raw("thunar"))
hl.bind("SUPER + B", hl.dsp.exec_raw("firefox"))
hl.bind("SUPER + R", hl.dsp.exec_raw("fuzzel --show-actions"))
hl.bind("SUPER + period", hl.dsp.exec_raw("bemoji"))
hl.bind("SUPER + backspace", hl.dsp.exec_raw("dms ipc powermenu toggle"))
hl.bind("SUPER + L", hl.dsp.exec_raw("dms ipc lock lock"))

hl.bind("SUPER + prior", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("SUPER + next", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

hl.bind("SUPER + CTRL + SHIFT + backspace", hl.dsp.exit())
