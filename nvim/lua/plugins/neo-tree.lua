return {
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
}
