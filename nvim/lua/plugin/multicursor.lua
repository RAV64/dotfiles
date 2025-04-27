local mc = function(f, args)
	return function()
		UTIL.func("multicursor-nvim", f, args)
	end
end

local opt = vim.opt
local v = vim.v
local nx = { "n", "x" }

local M = {}

M.match = function(direction)
	return function()
		if v.hlsearch == 0 then
			opt.ignorecase = false
			M.mc.matchAddCursor(direction)
		else
			M.mc.searchAddCursor(direction)
		end
	end
end

M.matchAll = function()
	if v.hlsearch == 0 then
		M.mc.matchAllAddCursors()
	else
		M.mc.searchAllAddCursors()
	end
end

M.skip = function(direction)
	return function()
		if v.hlsearch == 0 then
			M.mc.matchSkipCursor(direction)
		else
			M.mc.searchSkipCursor(direction)
		end
	end
end

M.plugin = {
	{
		"rav64/multicursor.nvim",
		-- upstream commit = "f3a4899e5cdc93e6f8cd06bbc3b3631a2e85a315",
		keys = {
			{ "<c-n>", M.match(1), mode = nx },
			{ "<c-p>", M.match(-1), mode = nx },
			{ "<up>", mc("lineAddCursor", -1), mode = nx },
			{ "<down>", mc("lineAddCursor", 1), mode = nx },

			{ "S", mc("splitCursors"), mode = { "x" } },
			{ "m", mc("matchCursors"), mode = { "x" } },
			{ "I", mc("insertVisual"), mode = { "x" } },
			{ "A", mc("appendVisual"), mode = { "x" } },

			{ "<c-a>", M.matchAll, mode = nx },
		},
		opts = { { signs = {} } },
		config = function(_, opts)
			M.mc = require("multicursor-nvim")
			M.mc.setup(opts)
			local default_ignorecase = opt.ignorecase

			M.mc.addKeymapLayer(function(layer)
				layer({ "n" }, "<esc>", function()
					M.mc.clearCursors()
					opt.ignorecase = default_ignorecase
				end)

				-- Select a different cursor as the main one.
				layer(nx, "n", M.mc.nextCursor)
				layer(nx, "N", M.mc.prevCursor)

				layer(nx, "<c-x>", M.mc.deleteCursor)

				layer(nx, "<c-s>", M.skip(1))
				layer(nx, "<c-a>", M.mc.alignCursors)

				layer("x", "t", function()
					M.mc.transposeCursors(1)
				end)
				layer("x", "T", function()
					M.mc.transposeCursors(-1)
				end)
			end)
		end,
	},
}

return M.plugin
