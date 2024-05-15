local M = {}

M.plugin = {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>n", "<cmd>Noice telescope<cr>", desc = "Notification history" },
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				-- hover = { enabled = false },
				-- signature = { enabled = false },
			},
			notify = { enabled = false },
			health = { checker = false },
			smart_move = { enabled = false },
			presets = {
				bottom_search = true,
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					view = "mini",
					filter = { event = "msg_showmode" },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = "auto",
						height = "auto",
					},

					border = {
						style = "none",
						padding = { 1, 2 },
					},
					filter_options = {},
					win_options = {
						winhighlight = {
							Normal = "NormalFloat",
						},
					},
				},
				popupmenu = {
					position = {
						row = 7,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "none",
						padding = { 1, 2 },
					},
					win_options = {
						winhighlight = {
							Normal = "NormalFloat",
						},
					},
				},
			},
		},
	},
}

return M.plugin
