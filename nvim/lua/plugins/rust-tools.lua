return {
	"simrat39/rust-tools.nvim",
	ft = "rust",
	config = function()
		require("rust-tools").setup({
			server = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						check = {
							command = "clippy",
							features = "all",
						},
						procMacro = {
							enable = true,
						},
					},
				},
				on_attach = function(client, bufnr)
					require("nvim-navic").attach(client, bufnr)
				end,
			},
		})
	end,
}
