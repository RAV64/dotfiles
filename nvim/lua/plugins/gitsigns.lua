return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>vb", "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", desc = "Line blame" },
		{ "<leader>vn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
		{ "<leader>vp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk" },
		{ "<leader>vs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		{ "<leader>vh", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Git status" },
	},
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "▎" },
			topdelete = { text = "▎" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		numhl = true,
		linehl = false,
	},
}
