return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},

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
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
			},
			icon = {
				folder_empty = "",
			},
		},
		close_if_last_window = false,
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},

			filtered_items = {
				visible = true,
			},
		},
		window = {
			mappings = {
				["<space>"] = "none",
			},
		},
	},
}
