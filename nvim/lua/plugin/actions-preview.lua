local func = require("config.util").func
local M = {}

M.plugin = {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>a",
			function()
				func("actions-preview", "code_actions")
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
}

return M.plugin
