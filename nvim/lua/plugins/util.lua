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
		event = "BufReadPre",
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
		"SmiteshP/nvim-navbuddy",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = { auto_attach = true },
			window = {
				border = "rounded",
				size = { height = "70%", width = "95%" },
				sections = {
					left = { size = "25%", border = nil },
					mid = { size = "25%", border = nil },
				},
			},
		},
		keys = { { "Å", "<cmd>Navbuddy<cr>", desc = "Hover" } },
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
	{
		"cameron-wags/rainbow_csv.nvim",
		config = function(_, _)
			vim.g.disable_rainbow_hover = 1
			require("rainbow_csv").setup()
		end,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},
}
