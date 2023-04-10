return {
	"akinsho/flutter-tools.nvim",
	ft = "dart",
	config = function()
		require("flutter-tools").setup({
			lsp = {
				on_attach = function(client, bufnr)
					require("nvim-navic").attach(client, bufnr)
				end,
			},
			widget_guides = {
				enabled = true,
			},
		})
	end,
}
