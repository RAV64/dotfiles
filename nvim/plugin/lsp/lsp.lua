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

local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap

local on_attach = function()
	nnoremap("gd", require("telescope.builtin").lsp_definitions)
	nnoremap("K", vim.lsp.buf.hover)
	nnoremap("gr", vim.lsp.buf.rename)
	nnoremap("gu", require("telescope.builtin").lsp_references)
	nnoremap("gD", vim.lsp.buf.declaration)
	nnoremap("gk", vim.diagnostic.goto_prev)
	nnoremap("gj", vim.diagnostic.goto_next)
	nnoremap("ge", vim.diagnostic.open_float)
	inoremap("<C-s>", vim.lsp.buf.signature_help)
	nnoremap("gf", vim.lsp.buf.format)
	nnoremap("gi", require("telescope.builtin").lsp_implementations)
	nnoremap("gt", require("telescope.builtin").lsp_type_definitions)
	nnoremap("ga", vim.lsp.buf.code_action)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

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
				diagnostics = {
					globals = {
						"vim",
					},
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
	jdtls = {
		settings = {},
		cmd = {
			"jdtls",
		},
	},
	rust_analyzer = {
		settings = {},
	},
}

for name, lsp in pairs(servers) do
	lspconfig[name].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = lsp.settings,
	})
end
