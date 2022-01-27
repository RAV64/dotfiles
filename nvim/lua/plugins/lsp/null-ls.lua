local status, null_ls = pcall(require, "null-ls")
if not status then
	print("ERROR: null-ls")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		diagnostics.flake8.with({extra_args = {"--ignore=E501"}}),
	},
})
