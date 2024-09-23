LOG = hs.logger.new("keybinding", "info")

local launch = hs.application.launchOrFocus
local hsbind = hs.hotkey.bind
local keystroke = hs.eventtap.keyStroke
local exec = os.execute

function EnterMode(mode)
	return function()
		mode.triggered = false
		mode:enter()
	end
end

function ExitMode(mode, or_key)
	return function()
		mode:exit()
		if not mode.triggered then
			keystroke({}, or_key)
		end
	end
end

local bind = function(mode, key, func)
	mode:bind({}, key, func, function()
		mode.triggered = true
	end)
end

RCMD = hs.hotkey.modal.new({}, "F19")
FN = hs.hotkey.modal.new({}, "F20")

F18 = hsbind({}, "F18", EnterMode(FN), ExitMode(FN, "fn"))
F17 = hsbind({}, "F17", EnterMode(RCMD), ExitMode(RCMD, "rightcmd"))

-- APP LAUNCHER --------------------------
local AppLauncher = function()
	local __AppLauncher = function(app_map)
		for key, app in pairs(app_map) do
			bind(RCMD, key, function()
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

		k = "microsoft word",
		b = "firefox developer edition",
		n = "Obsidian",
		s = "Bitwarden",
		t = "WezTerm",
		i = "Messages",
		y = "youtube",
		w = "teams",

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

ChangeVolume = function(diff)
	return function()
		local device = hs.audiodevice.defaultOutputDevice()
		local current = device:volume()
		local new = math.min(100, math.max(0, math.floor(current + diff)))
		if new > 0 then
			device:setMuted(false)
		end
		hs.alert.closeAll(0.0)
		hs.alert.show("Volume " .. new .. "%", {}, 0.5)
		device:setVolume(new)
	end
end

ChangeBrightness = function(diff)
	return function()
		local current = hs.brightness.get()
		local new = math.min(100, math.max(0, math.floor(current + diff)))
		hs.alert.closeAll(0.0)
		hs.alert.show("brightness " .. new .. "%", {}, 0.5)
		hs.brightness.set(new)
	end
end

ToggleMute = function()
	return function()
		local device = hs.audiodevice.defaultOutputDevice()
		if device:muted() then
			device:setMuted(false)
			hs.alert.show("Volume unmuted")
		else
			device:setMuted(true)
			hs.alert.show("Volume muted")
		end
	end
end

ToggleMedia = function()
	return function()
		hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
	end
end

BindToKey = function(key)
	return function()
		keystroke({}, key)
	end
end

ReloadHammerspoon = function()
	return function()
		hs.reload()
	end
end

Aerospace = function(cmd)
	return function()
		exec("/opt/homebrew/bin/aerospace " .. cmd)
	end
end

Noop = function()
	return function() end
end

return function(config)
	AppLauncher()
	hsbind("cmd", "space", config.launcher)
	hsbind("shift", "delete", BindToKey("forwarddelete"))
	hsbind("cmd", "h", Noop())
	bind(FN, "r", ReloadHammerspoon())

	bind(FN, "a", ChangeVolume(3))
	bind(FN, "z", ChangeVolume(-3))
	bind(FN, "m", ToggleMute())
	bind(FN, "q", ToggleMedia())
	bind(FN, "s", ChangeBrightness(7))
	bind(FN, "x", ChangeBrightness(-7))

	bind(FN, "t", Aerospace("layout tiles horizontal vertical"))
	bind(FN, "f", Aerospace("layout h_accordion"))
	bind(FN, "p", Aerospace("layout floating tiling"))
	bind(FN, "h", Aerospace("move left"))
	bind(FN, "j", Aerospace("move down"))
	bind(FN, "k", Aerospace("move up"))
	bind(FN, "l", Aerospace("move right"))
	for i = 1, 9 do
		bind(FN, tostring(i), Aerospace("workspace " .. i))
		bind(RCMD, tostring(i), Aerospace("move-node-to-workspace " .. i))
	end
end
