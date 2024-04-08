local M = {}

M.plugin = {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		branch = "0.1.x",
		version = false,
		-- stylua: ignore
		keys = {
		    { "<leader>f", function() M.builtin.find_files() end, desc = "Open file picker" },
		    { "<leader>F", function() M.builtin.find_files({ hidden = true, no_ignore = true }) end, desc = "Open file picker (ALL)" },
		    { "<leader>b", function() M.builtin.buffers() end, desc = "Open buffer picker" },
		    { "<leader>j", function() M.builtin.jumplist() end, desc = "Open jumplist picker" },
		    { "<leader>s", function() M.builtin.lsp_document_symbols() end, desc = "Open document symbol picker (LSP)" },
		    { "<leader>S", function() M.builtin.lsp_dynamic_workspace_symbols() end, desc = "Open workspace symbol picker (LSP)" },
		    { "<leader>d", function() M.builtin.diagnostics() end, desc = "Open workspace diagnostics picker (LSP)" },
		    { "<leader>l", function() M.builtin.live_grep() end, desc = "Global search in workspace folder" },
		    { "<leader>m", function() M.builtin.marks() end, desc = "File Marks" },
		    { "<leader>o", function() M.builtin.oldfiles() end, desc = "Previous files" },
		    { "<leader>.", function() M.builtin.resume() end, desc = "Open last builtin picker" },

		    { "gd", function() M.builtin.lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
		    { "gr", function() M.builtin.lsp_references() end, desc = "Get Usages" },
		    { "gi", function() M.builtin.lsp_implementations({ reuse_win = true }) end, desc = "Get implementations", },
		    { "gt", function() M.builtin.lsp_type_definitions({ reuse_win = true }) end, desc = "Get type definitions", },

		    { "<leader>vs", function() M.builtin.git_status() end, desc = "Git status" },
		    { "<leader>gh", function() M.builtin.help_tags() end, desc = "Find Help" },
		},
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			M.builtin = require("telescope.builtin")

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
				"<leader>a",
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

return M.plugin
