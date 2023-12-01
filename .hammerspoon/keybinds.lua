Super = { "cmd", "ctrl", "alt" }
Hyper = { "cmd", "ctrl", "alt", "shift" }

Launch = hs.application.launchOrFocus
Bind = hs.hotkey.bind

-- APP LAUNCHER --------------------------
__AppLauncher = function()
	AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			Bind(Super, key, function()
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
			Bind(Hyper, key, func)
		end
	end

	WindowManager({
		f = wm.maximizeWindow,
		c = wm.centerOnScreen,

		h = wm.leftHalf,
		j = wm.bottomHalf,
		k = wm.topHalf,
		l = wm.rightHalf,
	})
end

return function(config)
	__AppLauncher()
	__WindowManager(config.wm)
end
