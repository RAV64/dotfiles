local status, rt = pcall(require, "rust-tools")
if not status then
  print("ERROR: rust-tools")
  return
end

local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap

rt.setup({
  auto_focus = true,
  server = {
    on_attach = function(_, bufnr)
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

      nnoremap("<leader>ra", rt.hover_actions.hover_actions, { buffer = bufnr })
      nnoremap("<leader>rr", rt.runnables.runnables, { buffer = bufnr })
      nnoremap("<leader>rJ", rt.join_lines.join_lines, { buffer = bufnr })
    end,
  },
})
