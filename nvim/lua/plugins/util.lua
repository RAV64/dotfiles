return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<S-q>", "<cmd>bdelete<cr>", desc = "Delete current buffer" },
		},
	},

	{ "max397574/better-escape.nvim", event = "InsertEnter", config = true },

	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
    -- stylua: ignore
    keys = {
      { "<leader>n", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "<leader>N", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
	},
}
