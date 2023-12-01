SUPER = { "cmd", "ctrl", "alt" }
HYPER = { "cmd", "ctrl", "alt", "shift" }

Launch = hs.application.launchOrFocus
Bind = hs.hotkey.bind

-- APP LAUNCHER --------------------------
__AppLauncher = function()
	AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			Bind(SUPER, key, function()
				Launch(app)
			end)
		end
	end

	AppLauncher({
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
__WindowManager = function(wm)
	WindowManager = function(move)
		for key, func in pairs(move) do
			Bind(HYPER, key, func)
		end
	end

	WindowManager({
		f = wm.maximizeWindow,
		c = wm.centerOnScreen,

		h = wm.toHalf(wm.left_half),
		j = wm.toHalf(wm.bottom_half),
		k = wm.toHalf(wm.top_half),
		l = wm.toHalf(wm.right_half),
	})
end

return function(config)
	__AppLauncher()
	__WindowManager(config.wm)
end
