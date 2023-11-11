return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		keys = function()
			local telescope = require("telescope.builtin")
		-- stylua: ignore
		return {
			{ "<leader>ff", function() telescope.find_files() end, desc = "Find Files" },
			{ "<leader>fF", function() telescope.find_files({ hidden = true, no_ignore = true }) end, desc = "Find Files" },
			{ "<leader>fl", function() telescope.live_grep() end, desc = "Find Line" },
			{ "<leader>fb", function() telescope.buffers() end, desc = "File Browser" },
			{ "<leader>fh", function() telescope.help_tags() end, desc = "Find Help" },
			{ "<leader>fo", function() telescope.oldfiles() end, desc = "Previous files" },
			{ "<leader>fs", function() telescope.lsp_document_symbols() end, desc = "Find symbols" },
		}
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					borderchars = { " ", "", "", "", "", "", "", "" },
					initial_mode = "insert",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
						width = 0.95,
						height = 0.95,
						preview_cutoff = 10,
					},
					layout_strategy = "horizontal",
					mappings = {
						n = {
							["q"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
					path_display = { "truncate" },
					prompt_prefix = "  ",
					selection_caret = " ",
					selection_strategy = "reset",
					set_env = { ["COLORTERM"] = "truecolor" },
					sorting_strategy = "ascending",
					results_title = false,
					dynamic_preview_title = true,
				},
				extensions = {
					file_browser = {
						hidden = true,
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			telescope.load_extension("fzf")
		end,
	},

	{
		"aznhe21/actions-preview.nvim",
		keys = function()
			local actions = require("actions-preview")
			return {
				{
					"ga",
					function()
						actions.code_actions()
					end,
					desc = "Get code actions",
				},
			}
		end,
		opts = {
			telescope = {
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
					},
					width = 90,
					height = 0.80,
				},
			},
		},
	},
}
