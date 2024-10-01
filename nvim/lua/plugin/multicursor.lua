local M = {}

M.plugin = {
	{
		"jake-stewart/multicursor.nvim",
		event = "VeryLazy",
		branch = "snippet",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup({ signs = {} })

			local opt = vim.opt
			local set = vim.keymap.set

			set({ "n", "v" }, "<c-n>", function()
				opt.ignorecase = false
				mc.matchAddCursor(1)
			end)
			set({ "n", "v" }, "<c-p>", function()
				opt.ignorecase = false
				mc.matchAddCursor(-1)
			end)
			set({ "n", "v" }, "<c-s>", function()
				mc.matchSkipCursor(1)
			end)
			set({ "n", "v" }, "<c-S>", function()
				mc.matchSkipCursor(-1)
			end)

			set({ "n", "x" }, "<up>", mc.prevCursor)
			set({ "n", "x" }, "<down>", mc.nextCursor)
			set({ "n" }, "<c-x>", mc.deleteCursor)

			set("n", "<esc>", function()
				if mc.hasCursors() then
					mc.clearCursors()
				end
				opt.ignorecase = true
				vim.cmd("nohlsearch")
				return "<esc>"
			end)

			-- Align cursor columns.
			set("n", "<c-a>", mc.alignCursors)

			-- Split visual selections by regex.
			set("x", "m", mc.splitCursors)
			set("x", "S", mc.matchCursors)

			-- Append/insert for each line of visual selections.
			set("x", "I", mc.insertVisual)
			set("x", "A", mc.appendVisual)
		end,
	},
}

return M.plugin
