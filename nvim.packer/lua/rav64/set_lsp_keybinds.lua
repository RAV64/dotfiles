local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap

local telescope = require("telescope.builtin")
nnoremap("gd", telescope.lsp_definitions)
nnoremap("K", vim.lsp.buf.hover)
nnoremap("gr", vim.lsp.buf.rename)
nnoremap("gu", telescope.lsp_references)
nnoremap("gD", vim.lsp.buf.declaration)
nnoremap("gk", vim.diagnostic.goto_prev)
nnoremap("gj", vim.diagnostic.goto_next)
nnoremap("ge", vim.diagnostic.open_float)
inoremap("<C-s>", vim.lsp.buf.signature_help)
nnoremap("gf", vim.lsp.buf.format)
nnoremap("gi", telescope.lsp_implementations)
nnoremap("gt", telescope.lsp_type_definitions)
nnoremap("ga", vim.lsp.buf.code_action)
