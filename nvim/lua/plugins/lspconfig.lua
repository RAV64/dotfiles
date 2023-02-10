return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	version = false,
	dependencies = {
		{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
		{ "b0o/schemastore.nvim", version = false },
		{ "simrat39/rust-tools.nvim" },
		"hrsh7th/cmp-nvim-lsp",
		"SmiteshP/nvim-navic",
		"akinsho/flutter-tools.nvim",
	},
	keys = {
		{ "gf", vim.lsp.buf.format, desc = "Format" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gr", vim.lsp.buf.rename, desc = "Rename" },
		{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Get Declaration" },
		{ "gk", vim.diagnostic.goto_prev, desc = "Goto previous diagnostics" },
		{ "gj", vim.diagnostic.goto_next, desc = "Goto next diagnostics" },
		{ "ge", vim.diagnostic.open_float, desc = "Open diagnostics" },
		{ "ga", vim.lsp.buf.code_action, desc = "Get code actions" },
		{ "<C-s>", vim.lsp.buf.signature_help, desc = "Show signature", mode = "i" },
		{ "gu", "<cmd>Telescope lsp_references<cr>", desc = "Get Usages" },
		{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Get implementations" },
		{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Get type definitions" },
		{
			"n",
			"gwa",
			vim.lsp.buf.add_workspace_folder,
			desc = "add_workspace_folder",
		},
		{
			"n",
			"gwr",
			vim.lsp.buf.remove_workspace_folder,
			"remove_workspace_folder",
		},
		{
			"n",
			"gwl",
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"list_workspace_folders",
		},
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
							---@diagnostic disable-next-line: missing-parameter
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
			sqlls = {
				settings = {},
			},
			ruff_lsp = {
				settings = {},
			},
			dart = function(navic)
				require("flutter-tools").setup({
					lsp = {
						on_attach = function(client, bufnr)
							if client.server_capabilities.documentSymbolProvider then
								navic.attach(client, bufnr)
							end
						end,
					},
				})
			end,
			rust_analyzer = function(navic)
				local opts = {
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
							if client.server_capabilities.documentSymbolProvider then
								navic.attach(client, bufnr)
							end
						end,
					},
				}
				require("rust-tools").setup(opts)
			end,
		},
	},
	config = function(_, opts)
		vim.g.navic_silence = true
		local navic = require("nvim-navic")
		navic.setup({ highlight = true })
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local lspconfig = require("lspconfig")
		for name, lsp in pairs(opts.servers) do
			if name == "rust_analyzer" then
				lsp(navic)
			elseif name == "dart" then
				lsp(navic)
			else
				lspconfig[name].setup({
					capabilities = capabilities,
					settings = lsp.settings,
					on_attach = function(client, bufnr)
						if client.server_capabilities.documentSymbolProvider then
							navic.attach(client, bufnr)
						end
					end,
				})
			end
		end
	end,
}
