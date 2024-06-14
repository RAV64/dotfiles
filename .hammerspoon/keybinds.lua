SUPER = { "cmd", "ctrl", "alt" }
HYPER = { "cmd", "ctrl", "alt", "shift" }

LOG = hs.logger.new("keybinding", "info")

local launch = hs.application.launchOrFocus
local bind = hs.hotkey.bind

-- bind(SUPER, "p", function()
-- 	local app = hs.application.get("wezterm")
-- 	local x = app:activate()
-- 	LOG.e(x)
-- end)

-- APP LAUNCHER --------------------------
local AppLauncher = function()
	local __AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			bind(SUPER, key, function()
				local status = launch(app)
				if not status then
					LOG.e(app .. " does not exist")
				end
			end)
		end
	end

	__AppLauncher({
		a = "Music",
		c = "Calendar",
		f = "Finder",
		m = "Mail",
		h = "homeassistant",

		b = "firefox developer edition",
		n = "Obsidian",
		s = "Bitwarden",
		t = "WezTerm",
		i = "Messages",
		w = "Microsoft Teams (work or school)",

		escape = "Activity Monitor",
		[","] = "System Settings",
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
	return math.floor(color * 255)
end

return function(config)
	AppLauncher()
	bind("cmd", "space", config.launcher)
end
