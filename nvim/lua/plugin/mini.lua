local M = {}

M.plugin = {
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "ms",
				delete = "md",
				replace = "mr",

				-- Disable
				find = "",
				find_left = "",
				highlight = "",
				update_n_lines = "",
				suffix_last = "", -- Suffix to search with "prev" method
				suffix_next = "", -- Suffix to search with "next" method
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<S-q>",
				function()
					UTIL.func("mini.bufremove", "delete", 0, false)
				end,
				desc = "Delete Buffer",
			},
		},
	},
	{
		"echasnovski/mini.icons",
		config = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"echasnovski/mini.files",
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
}

return M.plugin
