return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    -- stylua: ignore
		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<leader>r", vim.lsp.buf.rename, desc = "Rename" },
			{ "gD", vim.lsp.buf.declaration, desc = "Get Declaration" },
			{ "Z", vim.diagnostic.goto_prev, desc = "Goto previous diagnostics" },
			{ "z", vim.diagnostic.goto_next, desc = "Goto next diagnostics" },
			{ "ge", vim.diagnostic.open_float, desc = "Open diagnostics" },
			{ "<C-s>", vim.lsp.buf.signature_help, desc = "Show signature", mode = "i" },
			{ "<leader>gwa", vim.lsp.buf.add_workspace_folder, desc = "add_workspace_folder" },
			{ "<leader>gwr", vim.lsp.buf.remove_workspace_folder, "remove_workspace_folder" },
			{ "<leader>gwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list_workspace_folders" },
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
					capabilities = capabilities,
					settings = lsp.settings,
					cmd = lsp.cmd,
				})
			end
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters = {
				sleek = {
					command = "sleek",
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix" },
				html = { "djlint" },
				rust = { "rustfmt" },
				sql = { "sleek" },
				toml = { "taplo" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
