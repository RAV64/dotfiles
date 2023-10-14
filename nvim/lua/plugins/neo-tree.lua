return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
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

	init = function()
		vim.g.neo_tree_remove_legacy_commands = 1
	end,

	opts = {
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
			},
		},
		close_if_last_window = false,
		filesystem = {
			use_libuv_file_watcher = true,
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
		icon = {
			folder_empty = "",
		},
	},
}
