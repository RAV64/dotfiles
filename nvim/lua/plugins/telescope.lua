return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fF", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
		{ "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Find Line" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "File Browser" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols" },
	},
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				borderchars = { " ", "", "", "", "", "", "", "" },
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
						["q"] = require("telescope.actions").close,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
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
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
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
		telescope.load_extension("file_browser")
	end,
}
