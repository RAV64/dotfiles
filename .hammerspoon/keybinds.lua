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
		b = "firefox nightly",
		c = "calendar",
		f = "finder",
		h = "homeassistant",
		m = "mail",
		n = "obsidian",
		t = "wezterm",
		w = "microsoft teams (work preview)",
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

		h = wm.toHalf(wm.left_half),
		j = wm.toHalf(wm.bottom_half),
		k = wm.toHalf(wm.top_half),
		l = wm.toHalf(wm.right_half),
	})
end

return function(config)
	AppLauncher()
	WindowManager(config.wm)
end
