local status, cp = pcall(require, "catppuccin")
if not status then
	print("ERROR: nvim-tree")
	return
end

cp.setup({
	styles = {
		comments = "NONE",
		functions = "NONE",
		keywords = "NONE",
		variables = "NONE",
	},
	integrations = {
		indent_blankline = {
			colored_indent_levels = true,
		},
		lsp_saga = true,
    lightspeed = true,
	},
})
vim.cmd([[colorscheme catppuccin]])
