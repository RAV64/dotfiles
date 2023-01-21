return {
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "tpope/vim-sleuth", event = "BufReadPost" },

	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<S-q>", "<cmd>bdelete<cr>", desc = "Delete current buffer" },
		},
	},

	{ "max397574/better-escape.nvim", event = "InsertEnter", config = true },
}
