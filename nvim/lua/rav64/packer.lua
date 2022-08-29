local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function(use)
	-- Packer and performance
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use("nathom/filetype.nvim")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
	use({ "p00f/nvim-ts-rainbow" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	-- Completions
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

	-- Lsp
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	use({ "~/git/catppuccin.nvim", as = "catppuccin", run = ":CatppuccinCompile" })
	use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" }, tag = "nightly" })
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	use("windwp/nvim-ts-autotag")
	use("windwp/nvim-autopairs")
	use("b0o/schemastore.nvim")
	use("mfussenegger/nvim-jdtls")
	use("terrortylor/nvim-comment")
	use("lukas-reineke/indent-blankline.nvim")
	use("lewis6991/gitsigns.nvim")
	use("simrat39/rust-tools.nvim")

	use("simrat39/symbols-outline.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("famiu/bufdelete.nvim")
	use("max397574/better-escape.nvim")
	use("mvllow/modes.nvim")
	use("ggandor/leap.nvim")
	use("kylechui/nvim-surround")
	use("gpanders/editorconfig.nvim")
end)
