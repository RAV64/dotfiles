return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	opts = function()
		local nls = require("null-ls").builtins
		return {
			sources = {
				-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
				nls.formatting.rome,
				nls.formatting.black.with({ extra_args = { "--fast" } }),
				nls.formatting.stylua,
				nls.formatting.csharpier,
				nls.diagnostics.flake8.with({ extra_args = { "--ignore=E501,W503" } }),
				nls.diagnostics.tsc,
				nls.diagnostics.fish,
				nls.code_actions.gitsigns,
			},
		}
	end,
}
