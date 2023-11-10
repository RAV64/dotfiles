return {
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "Aasim-A/scrollEOF.nvim", config = true, event = "VeryLazy" },
	{ "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },

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
		opts = {
			notify = false,
		},
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
		opts = {},
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"SmiteshP/nvim-navic",
		opts = function()
			vim.g.navic_silence = true
			return {
				lsp = { auto_attach = true },
				highlight = true,
				separator = "  ",
			}
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{
				"ga",
				function()
					require("actions-preview").code_actions()
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
					width = 90,
					height = 0.80,
				},
			},
		},
	},
}
