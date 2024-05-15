local M = {}

M.plugin = {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = { window = { winblend = 0 } },
					progress = { lsp = { progress_ringbuf_size = 500 } },
				},
			},
		},
		opts = {
			servers = {
				pyright = { cmd = { "bun", "run", "pyright-langserver", "--stdio" } },
				tsserver = { cmd = { "bun", "run", "typescript-language-server", "--stdio" } },
				bashls = { cmd = { "bun", "run", "bash-language-server", "start" } },
				cssls = { cmd = { "bun", "run", "vscode-css-language-server", "--stdio" } },
				html = { cmd = { "bun", "run", "vscode-html-language-server", "--stdio" } },
				-- tailwindcss = { cmd = { "bun", "run", "tailwindcss-language-server", "--stdio" } },
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = { globals = { "vim", "hs" } },
						},
					},
				},
				rust_analyzer = {
					capabilities = {
						experimental = {
							commands = {
								"rust-analyzer.runSingle",
								"rust-analyzer.showReferences",
								"rust-analyzer.gotoLocation",
								"editor.action.triggerParameterHints",
							},
							hoverActions = true,
							hoverRange = true,
							serverStatusNotification = true,
							snippetTextEdit = false,
							codeActionGroup = true,
							ssr = true,
						},
						textDocument = {
							completion = {
								completionItem = {
									resolveSupport = {
										properties = { "documentation", "detail", "additionalTextEdits" },
									},
								},
							},
						},
					},
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							procMacro = { enable = true },
							checkOnSave = true,
							check = {
								enable = true,
								command = "clippy",
								features = "all",
							},
						},
					},
				},
				csharp_ls = {},
				jsonls = {},
				clojure_lsp = {},
				zls = {},
				sqlls = {},
				ruff_lsp = {},
				astro = {},
				prismals = {},
				biome = {},
			},
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
			},
		},
		config = function(_, opts)
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local lspconfig = require("lspconfig")

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			)

			for name, lsp in pairs(opts.servers) do
				lspconfig[name].setup({
					capabilities = vim.tbl_deep_extend("force", capabilities, lsp.capabilities or {}),
					settings = lsp.settings,
					cmd = lsp.cmd,
				})
			end
		end,
	},
}

return M.plugin
