local mc = function(f, args)
	return function()
		UTIL.func("multicursor-nvim", f, args)
	end
end

local opt = vim.opt
local set = vim.keymap.set

local M = {}

M.plugin = {
	{
		"jake-stewart/multicursor.nvim",
		commit = "f3a4899e5cdc93e6f8cd06bbc3b3631a2e85a315",
    -- stylua: ignore
		keys = {
			{
				"<c-n>",
				function()
					opt.ignorecase = false
					UTIL.func("multicursor-nvim", "matchAddCursor", 1)
				end,
				mode = { "n", "v" },
			},
			{
				"<c-p>",
				function()
					opt.ignorecase = false
					UTIL.func("multicursor-nvim", "matchAddCursor", -1)
				end,
				mode = { "n", "v" },
			},
			{ "<c-x>", mc("deleteCursor"), mode = { "n" }, },
			{ "<c-s>", mc("matchSkipCursor", 1), mode = { "n", "v" }, },
			{ "<up>", mc("lineAddCursor", -1), mode = { "n", "v" }, },
			{ "<down>", mc("lineAddCursor", 1), mode = { "n", "v" }, },
			{ "<left>", mc("prevCursor"), mode = { "n", "x" }, },
			{ "<right>", mc("nextCursor"), mode = { "n", "x" }, },
			{ "<c-a>", mc("alignCursors"), mode = { "n" }, },
			{ "m", mc("splitCursors"), mode = { "x" }, },
			{ "S", mc("matchCursors"), mode = { "x" }, },
			{ "I", mc("insertVisual"), mode = { "x" }, },
			{ "A", mc("appendVisual"), mode = { "x" }, },
		},
		opts = { { signs = {} } },
		config = function(_, opts)
			local m = require("multicursor-nvim")
			m.setup(opts)

			set("n", "<esc>", function()
				if m.hasCursors() then
					m.clearCursors()
				end
				opt.ignorecase = true
				vim.cmd("nohlsearch")
				return "<esc>"
			end)
		end,
	},
}

return M.plugin
