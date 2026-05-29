require("hyprland_common")

hl.config({
	render = {
		cm_auto_hdr = 1,
	},
})

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@120",
	position = "0x0",
	scale = 1,
	vrr = 1,
	bitdepth = 8,
	sdrbrightness = 1.1,
	sdrsaturation = 1.2
})

hl.monitor({
	output = "DP-2",
	mode = "2560x1440@120",
	position = "2560x0",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-1",
	disabled = true,
	mode = "3840x2160@60.00",
	position = "5120x0",
	scale = 1
})

hl.workspace_rule({
	workspace = "1",
	monitor = "DP-1",
})

hl.workspace_rule({
	workspace = "2",
	monitor = "DP-2",
})

hl.on("hyprland.start", function()
	hl.exec_cmd("firefox", { workspace = 2 })
end)
