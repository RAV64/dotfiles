local status, _ = pcall(require, "lspconfig")
if not status then
	print("ERROR: lspconfig")
	return
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	print("ERROR: cmp_nvim_lsp")
	return
end

local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap

local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

M.on_attach = function()

	local action = require("lspsaga.codeaction")
	nnoremap("gd", require("lspsaga.definition").preview_definition)
	nnoremap("gD", function() require("lspsaga.finder"):lsp_finder() end)
	nnoremap("K", function() require("lspsaga.hover").render_hover_doc() end)
	nnoremap("gr", require("lspsaga.rename").lsp_rename)
	nnoremap("gk", function() require("lspsaga.diagnostic").goto_prev() end)
	nnoremap("gj", function() require("lspsaga.diagnostic").goto_next() end)
	-- nnoremap("gJ", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
	-- nnoremap("gK", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
	nnoremap("ge", function() require("lspsaga.diagnostic").show_line_diagnostics() end)
	inoremap("<C-s>", function() require("lspsaga.signaturehelp").signature_help() end)
	nnoremap("ga", function() action.code_action() end)
	nnoremap("<C-j>", function() action.smart_scroll_with_saga(1) end)
	nnoremap("<C-k>", function() action.smart_scroll_with_saga(-1) end)

	-- nnoremap("gd", vim.lsp.buf.definition)
	-- nnoremap("K", vim.lsp.buf.hover)
	-- nnoremap("gr", vim.lsp.buf.rename)
	-- nnoremap("gD", vim.lsp.buf.declaration)
	-- nnoremap("gk", vim.diagnostic.goto_prev)
	-- nnoremap("gj", vim.diagnostic.goto_next)
	-- nnoremap("ge", vim.diagnostic.open_float)
	-- inoremap("<C-s>", vim.lsp.buf.signature_help)
	nnoremap("gf", vim.lsp.buf.format)
	nnoremap("gi", vim.lsp.buf.implementation)
	nnoremap("gt", vim.lsp.buf.type_definition)
	-- nnoremap("ga", vim.lsp.buf.code_action)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local servers = {
	pyright = { settings = {}, cmd = {} },
	sumneko_lua = { settings = { Lua = { diagnostics = { globals = { "vim" } } } }, cmd = {} },
	tsserver = { settings = {}, cmd = {} },
	jsonls = { settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } }, },
	jdtls = { settings = {}, cmd = { "jdtls" } },
	rust_analyzer = { settings = {}, cmd = {} },
}

for name, lsp in pairs(servers) do
	require("lspconfig")[name].setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		settings = lsp.settings,
	})
end
