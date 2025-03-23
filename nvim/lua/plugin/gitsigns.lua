local M = {}

M.plugin = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
	keys = {
		{ "<leader>gb", function() M.gitsigns.blame() end, desc = "Line blame" },
		{ "<leader>gn", function() M.gitsigns.next_hunk() end, desc = "Next hunk" },
		{ "<leader>gp", function() M.gitsigns.prev_hunk() end, desc = "Previous hunk" },
		{ "<leader>gh", function() M.gitsigns.preview_hunk_inline() end, desc = "Preview hunk inline" },
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
		M.gitsigns = require("gitsigns")
		require("gitsigns").setup(opts)
	end,
}

return M.plugin
