local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Packer and performance
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use("nathom/filetype.nvim")
	use("tpope/vim-sleuth")
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")

	-- Treesitter
	use({ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use({ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	use({ "p00f/nvim-ts-rainbow" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
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

	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" }, tag = "nightly" })
	use({ "akinsho/bufferline.nvim", after = "catppuccin", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	use("windwp/nvim-ts-autotag")
	use("windwp/nvim-autopairs")
	use("b0o/schemastore.nvim")
	use("mfussenegger/nvim-jdtls")
	use("terrortylor/nvim-comment")
	use("lukas-reineke/indent-blankline.nvim")
	use("simrat39/rust-tools.nvim")

	use("simrat39/symbols-outline.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("famiu/bufdelete.nvim")
	use("max397574/better-escape.nvim")
	use("ggandor/leap.nvim")
	use("kylechui/nvim-surround")

	-- use({
	-- 	"saecki/crates.nvim",
	-- 	tag = "v0.3.0",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("crates").setup()
	-- 	end,
	-- })
	use("arkav/lualine-lsp-progress")
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
end)

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})
