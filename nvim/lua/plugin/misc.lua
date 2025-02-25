local M = {}

M.plugin = {
	{
		"RAV64/mini.icons",
		config = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"RAV64/mini.files",
		keys = {
			{
				"-",
				function()
					UTIL.func("mini.files", "open", vim.api.nvim_buf_get_name(0), false)
				end,
			},
		},
		opts = {
			mappings = {
				go_in = "",
				go_in_plus = "l",
				go_out = "h",
				go_out_plus = "",
			},
		},
	},
	{
		"folke/flash.nvim",
		opts = {
			highlight = {
				backdrop = false,
				matches = false,
			},
			modes = {
				char = { enabled = false },
				prompt = { enabled = false },
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					UTIL.func("flash", "jump")
				end,
				desc = "Flash",
			},
		},
	},
}

return M.plugin
