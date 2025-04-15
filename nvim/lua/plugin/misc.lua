local M = {}

M.plugin = {
	{
		"echasnovski/mini.icons",
		commit = "397ed3807e96b59709ef3292f0a3e253d5c1dc0a",
		lazy = false,
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
		commit = "432142ada983ec5863ba480f0e4891b7d64ce3f6",
		keys = {
			{
				"-",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
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
		commit = "3c942666f115e2811e959eabbdd361a025db8b63",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
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
	},

	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		commit = "d9ba6b7bfe29b3119a610892af67602641da778e",
		opts = {
			notification = {
				window = { winblend = 0 },
				override_vim_notify = true,
			},
		},
	},
}

return M.plugin
