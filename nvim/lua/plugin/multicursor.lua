local mc = require("multicursor-nvim")

local opt = vim.opt
local v = vim.v
local nx = { "n", "x" }

local match = function(direction)
	return function()
		if v.hlsearch == 0 then
			opt.ignorecase = false
			mc.matchAddCursor(direction)
		else
			mc.searchAddCursor(direction)
		end
	end
end

local matchAll = function()
	if v.hlsearch == 0 then
		mc.matchAllAddCursors()
	else
		mc.searchAllAddCursors()
	end
end

local skip = function(direction)
	return function()
		if v.hlsearch == 0 then
			mc.matchSkipCursor(direction)
		else
			mc.searchSkipCursor(direction)
		end
	end
end

mc.setup({ { signs = {} } })

local default_ignorecase = opt.ignorecase

mc.addKeymapLayer(function(layer)
	layer({ "n" }, "<esc>", function()
		mc.clearCursors()
		opt.ignorecase = default_ignorecase
	end)

	-- Select a different cursor as the main one.
	layer(nx, "n", mc.nextCursor)
	layer(nx, "N", mc.prevCursor)

	layer(nx, "<c-x>", mc.deleteCursor)

	layer(nx, "<c-s>", skip(1))
	layer(nx, "<c-a>", mc.alignCursors)

	layer("x", "t", function()
		mc.transposeCursors(1)
	end)
	layer("x", "T", function()
		mc.transposeCursors(-1)
	end)
end)

vim.keymap.set(nx, "<c-n>", match(1))
vim.keymap.set(nx, "<c-p>", match(-1))
vim.keymap.set(nx, "<c-a>", matchAll)

vim.keymap.set(nx, "<up>", function()
	mc.lineAddCursor(-1)
end)

vim.keymap.set(nx, "<down>", function()
	mc.lineAddCursor(1)
end)

vim.keymap.set("x", "S", function()
	mc.splitCursors()
end)

vim.keymap.set("x", "m", function()
	mc.matchCursors()
end)

vim.keymap.set("x", "I", function()
	mc.insertVisual()
end)

vim.keymap.set("x", "A", function()
	mc.appendVisual()
end)
