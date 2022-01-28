return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		{ "nvim-lualine/lualine.nvim" },
		{ "akinsho/bufferline.nvim" },
		requires = {
			{ "kyazdani42/nvim-web-devicons", opt = true },
		},
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		 "nvim-telescope/telescope.nvim" ,
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
	use({"sudormrfbin/cheatsheet.nvim"})
	use({ "nvim-telescope/telescope.nvim" })
	use("karb94/neoscroll.nvim")
	use("ms-jpq/chadtree")
	use("folke/tokyonight.nvim")
	use("windwp/nvim-autopairs")
	use("github/copilot.vim")
	use({ "ellisonleao/glow.nvim", run = ":GlowInstall" })
	use("blackCauldron7/surround.nvim")
	use("preservim/tagbar")
	use({ "lewis6991/gitsigns.nvim" })
	use("lukas-reineke/indent-blankline.nvim")
	use("tpope/vim-fugitive")
	use("famiu/bufdelete.nvim")
end)
