return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"b0o/SchemaStore.nvim",
	},
	opts = {
		servers = {
			jsonls = {
				on_new_config = function(new_config)
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = {
						format = {
							enable = true,
						},
						validate = { enable = true },
					},
				},
			},
		},
	},
}
