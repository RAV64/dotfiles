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
			},
			lualine_c = {
				{
					"navic",
					navic_opts = nil,
				},
			},
			lualine_x = {},
			lualine_y = {
				{
					"searchcount",
					maxcount = 999,
					timeout = 500,
				},
			},
			lualine_z = {
				{ "progress", separator = "", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
		},
		tabline = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"buffers",
					mode = 2,
					symbols = { alternate_file = "" },
					max_length = function()
						return vim.o.columns
					end,
					buffers_color = {
						active = "TablineActive", -- Color for active buffer.
						inactive = "TablineInactive", -- Color for inactive buffer.
					},
				},
			},
			lualine_x = { "diagnostics" },
			lualine_y = { "diff" },
			lualine_z = { "branch" },
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
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
