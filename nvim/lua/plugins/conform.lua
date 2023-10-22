return {
	"stevearc/conform.nvim",
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
			javascript = { { "prettierd", "prettier" } },
		},
	},
	config = function(_, opts)
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		require("conform").setup(opts)
	end,
}
