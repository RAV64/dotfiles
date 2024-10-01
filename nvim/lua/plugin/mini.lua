local M = {}

M.plugin = {
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",

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
					M.buf_delete(0, false)
				end,
				desc = "Delete Buffer",
			},
		},
		config = function()
			M.buf_delete = require("mini.bufremove").delete
		end,
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
					M.files.open(vim.api.nvim_buf_get_name(0), false)
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
		config = function(_, opts)
			M.files = require("mini.files")
			M.files.setup(opts)
		end,
	},
}

return M.plugin
