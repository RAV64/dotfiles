local gitsigns

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
	keys = {
		{ "<leader>vb", function() gitsigns.blame_line({ full = true }) end, desc = "Line blame" },
		{ "<leader>vn", function() gitsigns.next_hunk() end, desc = "Next hunk" },
		{ "<leader>vp", function() gitsigns.prev_hunk() end, desc = "Previous hunk" },
		{ "<leader>vh", function() gitsigns.preview_hunk_inline() end, desc = "Preview hunk inline" },
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

	config = function(_, opts)
		gitsigns = require("gitsigns")
		require("gitsigns").setup(opts)
	end,
}
