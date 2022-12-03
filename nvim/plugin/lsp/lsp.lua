local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("ERROR: lspconfig")
	return
end

local cpm_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cpm_nvim_lsp_status then
	print("ERROR: cmp_nvim_lsp")
	return
end

local on_attach = function()
	require("rav64.set_lsp_keybinds")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local servers = {
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
				schemas = require("schemastore").json.schemas(),
				validate = {
					enable = true,
				},
			},
		},
	},
	-- jdtls = {
	-- 	settings = {},
	-- },
	csharp_ls = {
		settings = {},
	},
	-- omnisharp = {
	-- 	settings = {},
	-- 	cmd = {
	-- 		"dotnet",
	-- 		"~/Downloads/omnisharp-osx-arm64-net6.0/OmniSharp.dll",
	-- 	},
	-- },
	zls = {
		settings = {},
	},
}

vim.diagnostic.config({ virtual_text = false })

for name, lsp in pairs(servers) do
	lspconfig[name].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = lsp.settings,
		cmd = lsp.cmd,
	})
end
