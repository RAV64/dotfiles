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

local navic_status, navic = pcall(require, "nvim-navic")
local aerial_status, aerial = pcall(require, "aerial")

local on_attach = function(client, bufnr)
	if navic_status then
		navic.attach(client, bufnr)
	end
	if aerial_status then
		aerial.on_attach(client, bufnr)
	end

	nnoremap("gd", vim.lsp.buf.definition)
	nnoremap("K", vim.lsp.buf.hover)
	nnoremap("gr", vim.lsp.buf.rename)
	nnoremap("gD", vim.lsp.buf.declaration)
	nnoremap("gk", vim.diagnostic.goto_prev)
	nnoremap("gj", vim.diagnostic.goto_next)
	nnoremap("ge", vim.diagnostic.open_float)
	inoremap("<C-s>", vim.lsp.buf.signature_help)
	nnoremap("gf", vim.lsp.buf.format)
	nnoremap("gi", vim.lsp.buf.implementation)
	nnoremap("gt", vim.lsp.buf.type_definition)
	nnoremap("ga", vim.lsp.buf.code_action)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local servers = {
	pyright = { settings = {} },
	bashls = { settings = {} },
	sumneko_lua = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
	tsserver = { settings = {} },
	jsonls = {
		settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
	},
	jdtls = { settings = {}, cmd = { "jdtls" } },
	rust_analyzer = { settings = {} },
}

for name, lsp in pairs(servers) do
	lspconfig[name].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = lsp.settings,
	})
end
