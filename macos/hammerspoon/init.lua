DBG = function(table)
	print(hs.inspect(table))
end

require("options")
STATE = {}
TASK = require("task")

Bluetooth = require("bluetooth")

TASK.hot_reload:start()
_ = TASK.on_state_change({
	[hs.caffeinate.watcher.systemWillSleep] = {
		function()
			Bluetooth(false)
		end,
	},
	[hs.caffeinate.watcher.systemDidWake] = {
		function()
			Bluetooth(true)
		end,
	},
}):start()

local wm = require("window-manager")
local launcher = require("launcher")

require("keybinds")({ wm = wm, launcher = launcher })
