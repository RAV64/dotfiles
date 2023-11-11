return {
	"stevearc/conform.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	keys = {
		{
			"gf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters = {
			rustfmt = {
				command = "rustfmt",
				args = { "+nightly", "--edition", "2021", "-q", "--emit=stdout" },
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_fix" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
