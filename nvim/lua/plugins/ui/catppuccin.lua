local status, cp = pcall(require, "catppuccin")
if not status then
	print("ERROR: catppuccin")
	return
end

cp.setup({
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
	integrations = {
		indent_blankline = {
			colored_indent_levels = { true },
		},
		lsp_saga = { true },
	},
})

vim.cmd([[colorscheme catppuccin]])
