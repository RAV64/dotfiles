local M = {}

M.plugin = {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = { window = { winblend = 0 }, override_vim_notify = true },
				},
			},
		},
		opts = {
			servers = {
				ts_ls = { cmd = { "bun", "run", "typescript-language-server", "--stdio" } },
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
							diagnostics = { globals = { "vim", "hs", "UTIL" } },
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
								-- "editor.action.triggerParameterHints",
							},
							codeActionGroup = false,
							hoverActions = false,
							hoverRange = false,
							serverStatusNotification = true,
							snippetTextEdit = false,
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
							-- cargo = { allFeatures = true },
							runBuildScripts = { enable = true },
							procMacro = { enable = true },
							checkOnSave = true,
							check = {
								enable = true,
								command = "clippy",
								-- features = "all",
							},
						},
					},
				},
				-- typos_lsp = {},
				csharp_ls = {},
				jsonls = {},
				clojure_lsp = {},
				zls = {},
				sqlls = {},

				astro = {},
				prismals = {},
				biome = {},
				nixd = {
					settings = {
						nixd = {
							nixpkgs = {
								expr = "import <nixpkgs> { }",
							},
							options = {
								home_manager = {
									expr = '(builtins.getFlake ("/Users/miki/dotfiles/nix-config")).darwinConfigurations.white-gharial.options.home-manager',
								},
								nix_darwin = {
									expr = '(builtins.getFlake ("/Users/miki/dotfiles/nix-config")).darwinConfigurations.white-gharial.options',
								},
							},
						},
					},
				},

				-- Python
				basedpyright = {},
				ruff = {},
			},
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
			},
		},
		config = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local lspconfig = require("lspconfig")

			local cmp = require("cmp_nvim_lsp")
			local capabilities = cmp.default_capabilities()

			for name, config in pairs(opts.servers) do
				config.capabilities = config.capabilities
						and vim.tbl_deep_extend("force", capabilities, config.capabilities)
					or capabilities
				lspconfig[name].setup(config)
			end
		end,
	},
}

return M.plugin
