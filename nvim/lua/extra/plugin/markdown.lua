local M = {}

M.plugin = {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown", -- If you decide to lazy-load anyway
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	},
}

return M.plugin
