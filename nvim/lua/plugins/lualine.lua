return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		extensions = { "neo-tree" },
		options = {
			theme = "catppuccin",
			disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
			globalstatus = true,
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"filetype",
					icon_only = true,
					separator = "",
					padding = { left = 1, right = 0 },
				},

				{ "filename", path = 1, symbols = { modified = "", readonly = "", unnamed = "" } },
				"diagnostics",
			},
			lualine_c = {
				{
					function()
						return require("nvim-navic").get_location()
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
				},
			},
			lualine_x = {},
			lualine_y = { "searchcount" },
			lualine_z = {
				{ "progress", separator = "",                   padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
		},
		tabline = {
			lualine_a = { "branch" },
			lualine_b = { "diff" },
			lualine_c = {
				{
					"buffers",
					mode = 2,
					symbols = { alternate_file = "" },
					max_length = vim.o.columns,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
	init = function()
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				vim.cmd("LualineBuffersJump! " .. i)
			end)
		end

		vim.keymap.set("n", "<leader>" .. 0, function()
			vim.cmd("LualineBuffersJump! $")
		end)
	end,
}
