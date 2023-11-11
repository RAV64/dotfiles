return {
	{ "nvim-treesitter/nvim-treesitter-context", config = true, event = "BufReadPost" },
	{ "Aasim-A/scrollEOF.nvim", config = true, event = "BufReadPre" },

	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
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
		opts = { notify = false },
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
		config = true,
	},
}
