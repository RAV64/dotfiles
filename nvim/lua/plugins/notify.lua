return {
	"rcarriga/nvim-notify",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Delete all Notifications",
		},
	},
	opts = {
		timeout = 3000,
		max_height = function()
			---@diagnostic disable-next-line: undefined-field
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			---@diagnostic disable-next-line: undefined-field
			return math.floor(vim.o.columns * 0.75)
		end,
		render = "compact",
		stages = "fade",
	},
	init = function()
		vim.notify = require("notify")
	end,
}
