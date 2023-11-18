local act = require("wezterm").action

local M = {}

function M.setup(config)
	config.keys = {
		{ key = "m", mods = "CMD", action = act.SplitHorizontal({}) },
		{ key = "n", mods = "CMD", action = act.SplitVertical({}) },
		{ key = "d", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "h", mods = "CMD", action = act({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = "CMD", action = act({ ActivatePaneDirection = "Right" }) },
		{ key = "k", mods = "CMD", action = act({ ActivatePaneDirection = "Up" }) },
		{ key = "j", mods = "CMD", action = act({ ActivatePaneDirection = "Down" }) },
		{ key = "h", mods = "CMD|SHIFT", action = act({ AdjustPaneSize = { "Left", 2 } }) },
		{ key = "l", mods = "CMD|SHIFT", action = act({ AdjustPaneSize = { "Right", 3 } }) },
		{ key = "k", mods = "CMD|SHIFT", action = act({ AdjustPaneSize = { "Up", 3 } }) },
		{ key = "j", mods = "CMD|SHIFT", action = act({ AdjustPaneSize = { "Down", 2 } }) },
	}
end
return M
