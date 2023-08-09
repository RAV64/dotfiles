return {
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "tpope/vim-sleuth",            event = "BufReadPost" },
	{ "Aasim-A/scrollEOF.nvim",      config = true, event = "VeryLazy" },

	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<S-q>", "<cmd>bdelete<cr>", desc = "Delete current buffer" },
		},
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jj", "qq" },
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		event = "BufReadPost",
		config = function()
			require("leap").set_default_keymaps()
		end,
	},
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ notify = false })
		end,
	},
}
