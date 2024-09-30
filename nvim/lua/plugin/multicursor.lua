local M = {}

M.plugin = {
	{
		"jake-stewart/multicursor.nvim",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			local set = vim.keymap.set

			set({ "n", "v" }, "<c-n>", function()
				mc.matchAddCursor(1)
			end)
			set({ "n", "v" }, "<c-p>", function()
				mc.matchAddCursor(-1)
			end)
			set({ "n", "v" }, "<c-s>", function()
				mc.matchSkipCursor(1)
			end)
			set({ "n", "v" }, "<c-S>", function()
				mc.matchSkipCursor(-1)
			end)

			-- Rotate the main cursor.
			set({ "n", "x" }, "<up>", mc.prevCursor)
			set({ "n", "x" }, "<down>", mc.nextCursor)

			-- Delete the main cursor.
			set({ "n" }, "<c-x>", mc.deleteCursor)

			set("n", "<esc>", function()
				if mc.hasCursors() then
					mc.clearCursors()
				end
				vim.cmd("nohlsearch")
				return "<esc>"
			end)

			-- Align cursor columns.
			set("n", "<c-a>", mc.alignCursors)

			-- Split visual selections by regex.
			set("x", "s", mc.splitCursors)
			set("x", "S", mc.matchCursors)

			-- Append/insert for each line of visual selections.
			set("x", "I", mc.insertVisual)
			set("x", "A", mc.appendVisual)

			-- Customize how cursors look.
			vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		end,
	},
}

return M.plugin
