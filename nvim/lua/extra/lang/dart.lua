return {
	"akinsho/flutter-tools.nvim",
	ft = "dart",
	config = function()
		require("flutter-tools").setup({
			widget_guides = {
				enabled = true,
			},
		})
	end,
}
