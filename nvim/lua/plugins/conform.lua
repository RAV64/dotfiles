return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
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
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "black" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		require("conform").setup(opts)
	end,
}
