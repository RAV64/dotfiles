local gitsigns = require("gitsigns")

gitsigns.setup({
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
})

local set = vim.keymap.set

set("n", "<leader>gb", gitsigns.blame, { desc = "Line blame" })
set("n", "<leader>gn", gitsigns.next_hunk, { desc = "Next hunk" })
set("n", "<leader>gp", gitsigns.prev_hunk, { desc = "Previous hunk" })
set("n", "<leader>gh", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })
