local M = {}

M.hot_reload = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload)

M.on_state_change = function(config)
	return hs.caffeinate.watcher.new(function(event)
		for _, func in ipairs(config[event] or {}) do
			func()
		end
	end)
end

return M
