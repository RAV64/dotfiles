require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
