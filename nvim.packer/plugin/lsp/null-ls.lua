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
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.rome,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.csharpier,
		diagnostics.flake8.with({ extra_args = { "--ignore=E501,W503" } }),
		diagnostics.tsc,
		null_ls.builtins.code_actions.gitsigns,
	},
})