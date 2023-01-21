return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			theme = "catppuccin",
			disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{ "diagnostics" },
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
				{
					function()
						return require("nvim-navic").get_location()
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
				},
			},
			lualine_x = {
				{
					function()
						return require("noice").api.status.command.get()
					end,
					cond = function()
						return package.loaded["noice"] and require("noice").api.status.command.has()
					end,
				},
				-- stylua: ignore
				{
					function() return require("noice").api.status.mode.get() end,
					cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
				},
				{ "diff" },
			},
			lualine_y = {
				{ "progress", separator = "", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function()
					return os.date("%R")
				end,
			},
		},
	},
}
