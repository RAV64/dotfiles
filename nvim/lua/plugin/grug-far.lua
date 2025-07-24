local grug = require("grug-far")

grug.setup({
	headerMaxWidth = 80,
	folding = {
		enabled = false,
	},
})

vim.keymap.set("n", "<leader>R", function()
	grug.open({ transient = true })
end, { desc = "Search and Replace" })
