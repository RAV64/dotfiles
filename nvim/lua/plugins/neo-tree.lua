return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
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
		close_if_last_window = true,
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
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
