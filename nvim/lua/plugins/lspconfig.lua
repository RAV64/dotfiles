return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	-- dependencies = { { "folke/neodev.nvim", config = true } },
	keys = function()
		local telescope = require("telescope.builtin")
		-- stylua: ignore
		return {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gr", vim.lsp.buf.rename, desc = "Rename" },
			{ "gd", function() telescope.lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Get Declaration" },
			{ "gk", vim.diagnostic.goto_prev, desc = "Goto previous diagnostics" },
			{ "gj", vim.diagnostic.goto_next, desc = "Goto next diagnostics" },
			{ "ge", vim.diagnostic.open_float, desc = "Open diagnostics" },
			{ "<C-s>", vim.lsp.buf.signature_help, desc = "Show signature", mode = "i" },
			{ "gu", function() telescope.lsp_references() end, desc = "Get Usages" },
			{ "gi", function() telescope.lsp_implementations({ reuse_win = true }) end, desc = "Get implementations", },
			{ "gt", function() telescope.lsp_type_definitions({ reuse_win = true }) end, desc = "Get type definitions", },
			{ "gwa", vim.lsp.buf.add_workspace_folder, desc = "add_workspace_folder" },
			{ "gwr", vim.lsp.buf.remove_workspace_folder, "remove_workspace_folder" },
			{ "gwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list_workspace_folders", },
		}
	end,
	opts = {
		servers = {
			pyright = { cmd = { "bun", "run", "pyright-langserver", "--stdio" } },
			tsserver = { cmd = { "bun", "run", "typescript-language-server", "--stdio" } },
			bashls = { cmd = { "bun", "run", "bash-language-server", "start" } },
			-- tailwindcss = { cmd = { "bun", "run", "tailwindcss-language-server", "--stdio" } },
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
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
		inlay_hints = { enabled = true },
	},
	config = function(_, opts)
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
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
				on_attach = function(client, bufnr)
					if opts.inlay_hints.enabled and inlay_hint then
						if client.supports_method("textDocument/inlayHint") then
							inlay_hint(bufnr, true)
						end
					end
				end,
			})
		end
	end,
}
