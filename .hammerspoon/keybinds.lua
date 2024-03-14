SUPER = { "cmd", "ctrl", "alt" }
HYPER = { "cmd", "ctrl", "alt", "shift" }

local launch = hs.application.launchOrFocus
local bind = hs.hotkey.bind

-- APP LAUNCHER --------------------------
local AppLauncher = function()
	local __AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			bind(SUPER, key, function()
				launch(app)
			end)
		end
	end

	__AppLauncher({
		a = "music",
		s = "bitwarden",
		b = "orion",
		c = "calendar",
		f = "finder",
		h = "homeassistant",
		m = "mail",
		n = "obsidian",
		t = "wezterm",
		w = "microsoft teams (work or school)",
	})
end

-- WINDOW MANAGER ------------------------
local WindowManager = function(wm)
	local __WindowManager = function(move)
		for key, func in pairs(move) do
			bind(HYPER, key, func)
		end
	end

	__WindowManager({
		f = wm.maximizeWindow,
		c = wm.centerOnScreen,

		m = wm.moveTo(wm.almost_maximize),
		h = wm.moveTo(wm.left_half),
		j = wm.moveTo(wm.bottom_half),
		k = wm.moveTo(wm.top_half),
		l = wm.moveTo(wm.right_half),
	})
end

ColorSnapper = function()
	local screen = hs.mouse.getCurrentScreen()
	local mode = hs.screen.mainScreen():currentMode()

	local current = hs.mouse.getAbsolutePosition()
	current.x = current.x * 2
	current.y = (mode.h - current.y) * 2

	local image = screen:snapshot()
	local color = image:colorAt(current)
	local rgb = hs.drawing.color.asRGB(color)

	local rgb_string = table.concat({ ToRGB(rgb.red), ToRGB(rgb.green), ToRGB(rgb.blue) }, ", ")
	hs.pasteboard.setContents(rgb_string)
end

function ToRGB(color)
	return color * 255
end

return function(config)
	AppLauncher()
	WindowManager(config.wm)
	bind(HYPER, "1", ColorSnapper)
end
