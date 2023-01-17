local config = {
	cmd = { "/opt/homebrew/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)

local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap

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
