return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	tag = "0.1.1",
	version = false,
	event = "VeryLazy",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",   desc = "Find Files" },
		{ "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
		{ "<leader>fl", "<cmd>Telescope live_grep<cr>",    desc = "Find Line" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "File Browser" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Find Help" },
	},
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			defaults = {
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				dynamic_preview_title = true,
				-- file_sorter = require("telescope.sorters").get_fuzzy_file,
				-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				initial_mode = "insert",
				layout_strategy = "horizontal",
				prompt_prefix = "🔭 ",
				prompt_position = "top",
				path_display = { "truncate" },
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- results_width = 1,
				selection_strategy = "reset",
				selection_caret = " ",
				set_env = { ["COLORTERM"] = "truecolor" },
				sorting_strategy = "ascending",
				file_ignore_patterns = {
					"node_modules",
					"venv",
					"packer_compiled.lua",
					".git/",
					".cache",
					".gradle",
					"pytorch",
					"target",
					"*.gpg",
				},
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.4,
					},
					width = 0.99,
					height = 0.99,
					preview_cutoff = 120,
				},
			},
			extensions = {
				file_browser = {
					hidden = true,
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("ui-select")
	end,
}
