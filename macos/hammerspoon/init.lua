DBG = function(table)
	print(hs.inspect(table))
end

require("options")
STATE = {}
TASK = require("task")

Bluetooth = require("bluetooth")
Wifi = require("wifi")

TASK.hot_reload:start()
_ = TASK.on_state_change({
	[hs.caffeinate.watcher.systemWillSleep] = {
		function()
			print("systemWillSleep")
			Bluetooth(false)
			Wifi.handleSleep()
		end,
	},
	[hs.caffeinate.watcher.systemDidWake] = {
		function()
			print("systemDidWake")
			Bluetooth(true)
			Wifi.handleWake()
		end,
	},
}):start()

local wm = require("window-manager")
local launcher = require("launcher")

require("keybinds")({ wm = wm, launcher = launcher })
