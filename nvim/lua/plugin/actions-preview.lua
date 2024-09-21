local M = {}

M.plugin = {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>a",
			function()
				M.actions.code_actions()
			end,
			desc = "Get code actions",
		},
	},
	opts = {
		telescope = {
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					prompt_position = "top",
				},
				width = 0.95,
				height = 0.95,
			},
		},
	},
	config = function(_, opts)
		M.actions = require("actions-preview")
		M.actions.setup(opts)
	end,
}

return M.plugin
