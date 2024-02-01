return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>fn", "<cmd>Noice telescope<cr>", desc = "Notification history" },
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

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"å",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
		},

		opts = {
			sources = { "filesystem", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "qf" },
			default_component_configs = {
				file_size = { enabled = false },
				type = { enabled = false },
				last_modified = { enabled = false },
				created = { enabled = false },
			},
			close_if_last_window = false,
			filesystem = {
				bind_to_cwd = false,
				use_libuv_file_watcher = true,
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				filtered_items = {
					visible = true,
					never_show = { ".DS_Store" },
				},
			},
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
		},
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			no_italic = true,
			flavour = "mocha",
			transparent_background = false,
			integrations = {
				alpha = false,
				dashboard = false,
				neogit = false,
				nvimtree = false,
				ufo = false,
				dap = { enabled = false, enable_ui = false },

				neotree = true,
				noice = true,
			},
			color_overrides = {
				mocha = {
					text = "#dde1e6",
					base = "#202020",
					mantle = "#161616",
					surface0 = "#262626",
					surface1 = "#393939",
					surface2 = "#525252",
					overlay0 = "#ffffff",
					overlay1 = "#f2f4f8",
					overlay2 = "#dde1e6",
					-- mauve = "#be95ff",
					-- green = "#8fca5c",
					maroon = "#ee5396",
					-- lavender = "#78a9ff",
					red = "#ea7183",
					peach = "#f39967",
					yellow = "#eaca89",
					green = "#96d382",
					-- blue = "#3ddbd9"
				},
			},
			custom_highlights = function(C)
				local base = C.base
				local tPreview = "#181818"
				return {
					CursorLine = { bg = C.surface1 },
					TelescopeNormal = { bg = C.mantle },
					TelescopeBorder = { bg = C.mantle },
					TelescopePromptNormal = { bg = C.surface0 },
					TelescopePromptBorder = { bg = C.surface0 },
					TelescopePromptTitle = { bg = C.surface0 },

					TelescopePreviewNormal = { bg = tPreview },
					TelescopePreviewBorder = { bg = tPreview },

					NormalFloat = { bg = C.mantle },
					TablineActive = { fg = C.overlay1, bg = C.mantle },
					TablineInactive = { fg = "#90A4AE", bg = C.mantle },
					NeoTreeDirectoryIcon = { fg = "#be95ff" },
					CmpBackground = { bg = C.mantle },

					LazyNormal = { bg = C.mantle },
					CmpGhostText = { italic = true },

					CmpItemKindSnippet = { fg = base, bg = C.mauve },
					CmpItemKindKeyword = { fg = base, bg = C.red },
					CmpItemKindText = { fg = base, bg = C.teal },
					CmpItemKindMethod = { fg = base, bg = C.blue },
					CmpItemKindConstructor = { fg = base, bg = C.blue },
					CmpItemKindFunction = { fg = base, bg = C.blue },
					CmpItemKindFolder = { fg = base, bg = C.blue },
					CmpItemKindModule = { fg = base, bg = C.blue },
					CmpItemKindConstant = { fg = base, bg = C.peach },
					CmpItemKindField = { fg = base, bg = C.green },
					CmpItemKindProperty = { fg = base, bg = C.green },
					CmpItemKindEnum = { fg = base, bg = C.green },
					CmpItemKindUnit = { fg = base, bg = C.green },
					CmpItemKindClass = { fg = base, bg = C.yellow },
					CmpItemKindVariable = { fg = base, bg = C.flamingo },
					CmpItemKindFile = { fg = base, bg = C.blue },
					CmpItemKindInterface = { fg = base, bg = C.yellow },
					CmpItemKindColor = { fg = base, bg = C.red },
					CmpItemKindReference = { fg = base, bg = C.red },
					CmpItemKindEnumMember = { fg = base, bg = C.red },
					CmpItemKindStruct = { fg = base, bg = C.blue },
					CmpItemKindValue = { fg = base, bg = C.peach },
					CmpItemKindEvent = { fg = base, bg = C.blue },
					CmpItemKindOperator = { fg = base, bg = C.blue },
					CmpItemKindTypeParameter = { fg = base, bg = C.blue },
					CmpItemKindCopilot = { fg = base, bg = C.teal },
					NeoTreeWinSeparator = { fg = C.mantle, bg = C.mantle },
					TreeSitterContext = { bg = C.mantle },
					TreeSitterContextBottom = { underline = true },
					TreeSitterContextLineNumber = { fg = C.overlay2, bg = C.mantle },
					["@codeblock"] = { bg = C.surface0 },
					["@comment"] = { italic = true, fg = C.rosewater },
					LspInlayHint = { fg = "#90A4AE", bg = "None", italic = true },
					Visual = { bg = "#56496b" },

					StatusLineGreen = { fg = C.green, bg = C.mantle },
					StatusLineYellow = { fg = C.yellow, bg = C.mantle },
					StatusLineRed = { fg = C.red, bg = C.mantle },
					StatusLineBlue = { fg = C.blue, bg = C.mantle },

					StatusLineModeNOR = { fg = C.mantle, bg = C.blue },
					StatusLineModePEN = { fg = C.mantle, bg = C.flamingo },
					StatusLineModeVIS = { fg = C.mantle, bg = "#56496b" },
					StatusLineModeINS = { fg = C.mantle, bg = C.green },
					StatusLineModeCOM = { fg = C.mantle, bg = C.flamingo },
					StatusLineModeUNK = { fg = C.mantle, bg = C.peach },
				}
			end,
		},
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
