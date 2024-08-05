local M = {}

M.plugin = {
	{
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		ft = { "markdown", "markdown-inline" },
		config = function()
			require("render-markdown").setup({ file_types = { "markdown", "vimwiki" } })
		end,
	},
}

return M.plugin
