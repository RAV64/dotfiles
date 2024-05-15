local M = {}

M.plugin = {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>a",
			function()
				require("actions-preview").code_actions()
			end,
			desc = "Get code actions",
		},
	},
	config = function()
		require("actions-preview").setup({
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
		})
	end,
}

return M.plugin
