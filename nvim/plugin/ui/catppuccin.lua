local status, cp = pcall(require, "catppuccin")
if not status then
	print("ERROR: catppuccin")
	return
end

cp.setup({
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	styles = {
		comments = {},
		conditionals = {},
	},
	integrations = {
		indent_blankline = {
			colored_indent_levels = { true },
		},
    bufferline = true,
		lsp_saga = true,
		leap = true,
		dashboard = false,
		telekasten = false,
		symbols_outline = false,
	},
})

vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
