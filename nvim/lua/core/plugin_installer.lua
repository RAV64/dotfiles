return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "lewis6991/impatient.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
	})
	use({
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/nvim-lsp-installer" },
		{ "jose-elias-alvarez/null-ls.nvim" },
	})

	use({ "tami5/lspsaga.nvim" })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
	})

	use("kyazdani42/nvim-web-devicons")
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/bufferline.nvim" })
	use({ "ellisonleao/glow.nvim", run = ":GlowInstall" })
	use("sudormrfbin/cheatsheet.nvim")
	use("ms-jpq/chadtree")
	use("folke/tokyonight.nvim")
	use("windwp/nvim-autopairs")
	--use("github/copilot.vim")
	use("blackCauldron7/surround.nvim")
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")
	use("famiu/bufdelete.nvim")
	use("rust-lang/rust.vim")
	use("ggandor/lightspeed.nvim")
	use("max397574/better-escape.nvim")
	use({ "p00f/nvim-ts-rainbow" })
end)
