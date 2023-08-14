return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
		"hrsh7th/cmp-nvim-lsp",
		"SmiteshP/nvim-navic",
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
			"gwa",
			vim.lsp.buf.add_workspace_folder,
			desc = "add_workspace_folder",
		},
		{
			"gwr",
			vim.lsp.buf.remove_workspace_folder,
			"remove_workspace_folder",
		},
		{
			"gwl",
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"list_workspace_folders",
		},
	},
	opts = {
		servers = {
			pyright = {},
			bashls = {
				cmd = {
					"bun",
					"run",
					"bash-language-server",
					"start",
				},
			},
			lua_ls = {
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
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			tsserver = {
				cmd = { "bun", "run", "typescript-language-server", "--stdio" },
			},
			csharp_ls = {},
			zls = {},
			sqlls = {},
			ruff_lsp = {},
			astro = {},
			prismals = {},
			textlsp = {},
			tailwindcss = {
				cmd = { "bun", "run", "tailwindcss-language-server", "--stdio" },
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						check = {
							command = "clippy",
							features = "all",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
		},
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		},

		inlay_hints = {
			enabled = true,
		},

		format_notify = false,
	},
	config = function(_, opts)
		vim.g.navic_silence = true
		local navic = require("nvim-navic")
		navic.setup({ highlight = true })
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local lspconfig = require("lspconfig")

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

		for name, lsp in pairs(opts.servers) do
			lspconfig[name].setup({
				capabilities = capabilities,
				settings = lsp.settings,
				cmd = lsp.cmd,
				on_attach = function(client, bufnr)
					if client.server_capabilities.documentSymbolProvider then
						navic.attach(client, bufnr)
					end

					if opts.inlay_hints.enabled and inlay_hint then
						if client.supports_method("textDocument/inlayHint") then
							inlay_hint(bufnr, true)
						end
					end
				end,
			})
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
	end,
}
