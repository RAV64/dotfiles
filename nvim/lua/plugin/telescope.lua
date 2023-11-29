local builtin

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		-- stylua: ignore
		keys = {
      { "<leader>ff", function() builtin.find_files() end, desc = "Find Files" },
      { "<leader>fF", function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = "Find Files" },
      { "<leader>fl", function() builtin.live_grep() end, desc = "Find Line" },
      { "<leader>fb", function() builtin.buffers() end, desc = "File Browser" },
      { "<leader>fm", function() builtin.marks() end, desc = "File Marks" },
      { "<leader>fh", function() builtin.help_tags() end, desc = "Find Help" },
      { "<leader>fo", function() builtin.oldfiles() end, desc = "Previous files" },
      { "<leader>fs", function() builtin.lsp_document_symbols() end, desc = "Find symbols" },
      { "<leader>fws", function() builtin.lsp_workspace_symbols() end, desc = "Find workspace symbols" },
      { "<leader>vs", function() builtin.git_status() end, desc = "Git status" },
      { "<leader>fd", function() builtin.diagnostics() end, desc = "LSP diagnostics" },
      { "gd", function() builtin.lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
      { "gu", function() builtin.lsp_references() end, desc = "Get Usages" },
      { "gi", function() builtin.lsp_implementations({ reuse_win = true }) end, desc = "Get implementations", },
      { "gt", function() builtin.lsp_type_definitions({ reuse_win = true }) end, desc = "Get type definitions", },
		},
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			builtin = require("telescope.builtin")

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
		keys = {
			{
				"ga",
				function()
					require("actions-preview").code_actions()
				end,
				desc = "Get code actions",
			},
		},
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
