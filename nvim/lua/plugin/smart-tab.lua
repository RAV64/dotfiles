local M = {}

M.plugin = {
	{
		"boltlessengineer/smart-tab.nvim",
		keys = {
			{
				"<tab>",
				function()
					M.smart_tab()
				end,
				mode = "i",
			},
		},
		opts = {
			skips = {},
			mapping = false,
		},
		config = function(_, opts)
			local st = require("smart-tab")
			st.setup(opts)
			M.smart_tab = st.smart_tab
		end,
	},
}

return M.plugin
