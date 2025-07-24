local gitsigns = require("gitsigns")

vim.keymap.set("n", "<leader>gb", function()
	gitsigns.blame()
end, { desc = "Line blame" })

vim.keymap.set("n", "<leader>gn", function()
	gitsigns.next_hunk()
end, { desc = "Next hunk" })

vim.keymap.set("n", "<leader>gp", function()
	gitsigns.prev_hunk()
end, { desc = "Previous hunk" })

vim.keymap.set("n", "<leader>gh", function()
	gitsigns.preview_hunk_inline()
end, { desc = "Preview hunk inline" })

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
