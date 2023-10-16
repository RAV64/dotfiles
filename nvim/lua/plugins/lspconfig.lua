return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		{
			"SmiteshP/nvim-navic",
			opts = function()
				vim.g.navic_silence = true
				return {
					lsp = { auto_attach = true },
					highlight = true,
				}
			end,
		},
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = { "MunifTanjim/nui.nvim" },
			opts = {
				lsp = { auto_attach = true },
				window = {
					border = "rounded",
					size = { height = "70%", width = "95%" },
					sections = {
						left = { size = "25%", border = nil },
						mid = { size = "25%", border = nil },
					},
				},
			},
			keys = { { "Å", "<cmd>Navbuddy<cr>", desc = "Hover" } },
		},
	},

	-- stylua: ignore
	keys = {
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gr", vim.lsp.buf.rename, desc = "Rename" },
		{ "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Get Declaration" },
		{ "gk", vim.diagnostic.goto_prev, desc = "Goto previous diagnostics" },
		{ "gj", vim.diagnostic.goto_next, desc = "Goto next diagnostics" },
		{ "ge", vim.diagnostic.open_float, desc = "Open diagnostics" },
		{ "ga", vim.lsp.buf.code_action, desc = "Get code actions" },
		{ "<C-s>", vim.lsp.buf.signature_help, desc = "Show signature", mode = "i" },
		{ "gu", "<cmd>Telescope lsp_references<cr>", desc = "Get Usages" },
		{ "gi", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Get implementations" },
		{ "gt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Get type definitions" },
		{ "gwa", vim.lsp.buf.add_workspace_folder, desc = "add_workspace_folder"},
		{ "gwr", vim.lsp.buf.remove_workspace_folder, "remove_workspace_folder"},
		{ "gwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list_workspace_folders"},
	},
	opts = {
		servers = {
			pyright = { cmd = { "bun", "run", "pyright-langserver", "--stdio" } },
			tsserver = { cmd = { "bun", "run", "typescript-language-server", "--stdio" } },
			bashls = { cmd = { "bun", "run", "bash-language-server", "start" } },
			-- tailwindcss = { cmd = { "bun", "run", "tailwindcss-language-server", "--stdio" } },
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						check = {
							command = "clippy",
							features = "all",
							extraArgs = { "--no-deps" },
						},
						procMacro = { enable = true },
					},
				},
			},
			csharp_ls = {},
			clojure_lsp = {},
			zls = {},
			sqlls = {},
			ruff_lsp = {},
			astro = {},
			prismals = {},
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
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			has_cmp and cmp_nvim_lsp.default_capabilities() or {}
		)

		local lspconfig = require("lspconfig")

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

		for name, lsp in pairs(opts.servers) do
			lspconfig[name].setup({
				capabilities = capabilities,
				settings = lsp.settings,
				cmd = lsp.cmd,
				on_attach = function(client, bufnr)
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
