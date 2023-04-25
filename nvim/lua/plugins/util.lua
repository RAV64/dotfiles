return {
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "tpope/vim-sleuth",            event = "BufReadPost" },

	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<S-q>", "<cmd>bdelete<cr>", desc = "Delete current buffer" },
		},
	},

	{ "max397574/better-escape.nvim", event = "InsertEnter", config = true },
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
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},
}
