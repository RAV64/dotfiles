local chadtree_settings = {
	view = { width = 27 },
	theme = {
		text_colour_set = "nord",
	},
	["keymap.quit"] = { "q" },
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
