return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
		{ "b0o/schemastore.nvim", version = false },
		"hrsh7th/cmp-nvim-lsp",
	},
	keys = {
		{ "gf", vim.lsp.buf.format, desc = "Format" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gr", vim.lsp.buf.rename, desc = "Rename" },
		{ "gD", vim.lsp.buf.declaration, desc = "Get Declaration" },
		{ "gk", vim.diagnostic.goto_prev, desc = "Goto previous diagnostics" },
		{ "gj", vim.diagnostic.goto_next, desc = "Goto next diagnostics" },
		{ "ge", vim.diagnostic.open_float, desc = "Open diagnostics" },
		{ "ga", vim.lsp.buf.code_action, desc = "Get code actions" },
		{ "<C-s>", vim.lsp.buf.signature_help, desc = "Show signature", mode = "i" },
		{ "gu", "<cmd>Telescope lsp_references<cr>", desc = "Get Usages" },
		{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Get implementations" },
		{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Get type definitions" },
	},
	opts = {
		servers = {
			pyright = {
				settings = {},
			},
			bashls = {
				settings = {},
			},
			sumneko_lua = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			tsserver = {
				settings = {},
			},
			jsonls = {
				settings = {
					json = {
						on_new_config = function(new_config)
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
						end,
						validate = {
							enable = true,
						},
					},
				},
			},
			csharp_ls = {
				settings = {},
			},
			zls = {
				settings = {},
			},
		},
	},

	config = function(_, opts)
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local lspconfig = require("lspconfig")
		for name, lsp in pairs(opts.servers) do
			lspconfig[name].setup({
				capabilities = capabilities,
				settings = lsp.settings,
			})
		end
	end,
}
