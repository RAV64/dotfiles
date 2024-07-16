local M = {}

M.plugin = {
	{
		"boltlessengineer/smart-tab.nvim",

		event = "InsertEnter",
		opts = {
			skips = {},
			mapping = false,
		},
		config = function(_, opts)
			local st = require("smart-tab")
			st.setup(opts)
			vim.keymap.set("i", "<tab>", st.smart_tab)
		end,
	},
}

return M.plugin
