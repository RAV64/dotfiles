SUPER = { "cmd", "ctrl", "alt" }
HYPER = { "cmd", "ctrl", "alt", "shift" }

local launch = hs.application.launchOrFocusByBundleID
local bind = hs.hotkey.bind

function AppID(app)
	local info = hs.application.infoForBundlePath(app)
	return info and info["CFBundleIdentifier"] or app
end

-- APP LAUNCHER --------------------------
local AppLauncher = function()
	local __AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			local app_id = AppID(app)
			bind(SUPER, key, function()
				local status = launch(app_id)
				if not status then
					print("ERROR: {" .. app_id .. "} does not exist")
				end
			end)
		end
	end

	__AppLauncher({
		a = "/System/Applications/Music.app",
		c = "/System/Applications/Calendar.app",
		f = "/System/Library/CoreServices/Finder.app",
		m = "/System/Applications/Mail.app/",

		h = "~/Applications/homeassistant.app/",

		b = "/Applications/Orion.app",
		n = "/Applications/Obsidian.app/",
		s = "/Applications/Bitwarden.app",
		t = "/Applications/WezTerm.app",
		w = "/Applications/Microsoft Teams.app",
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
