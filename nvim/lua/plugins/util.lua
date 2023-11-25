return {
	{ "nvim-treesitter/nvim-treesitter-context", config = true, event = "BufReadPost" },
	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
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
		opts = { notify = false },
	},
}
