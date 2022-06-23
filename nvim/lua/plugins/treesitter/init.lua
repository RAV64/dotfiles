local status, tsc = pcall(require, "nvim-treesitter.configs")
if not status then
	print("ERROR lualine")
	return
end

tsc.setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})
require("nvim-ts-autotag").setup()
