return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
	keys = {
		{ "<leader>vb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Line blame" },
		{ "<leader>vn", function() require("gitsigns").next_hunk() end, desc = "Next hunk" },
		{ "<leader>vp", function() require("gitsigns").prev_hunk() end, desc = "Previous hunk" },
		{ "<leader>vs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
		{ "<leader>vh", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview hunk inline" },
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
