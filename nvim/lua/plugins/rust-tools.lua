return {
	"simrat39/rust-tools.nvim",
	event = "BufReadPost",
	opts = {
		server = {
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	},
	init = function()
		local rt = require("rust-tools")
		vim.keymap.set("n", "<leader>ra", rt.hover_actions.hover_actions)
		vim.keymap.set("n", "<leader>rr", rt.runnables.runnables)
		vim.keymap.set("n", "<leader>rJ", rt.join_lines.join_lines)
	end,
}
