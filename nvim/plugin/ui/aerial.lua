local aerial_status, aerial = pcall(require, "aerial")
if not aerial_status then
  print("ERROR: aerial")
  return
end

aerial.setup({
  filter_kind = false,
})

local nnoremap = require("rav64.keymaps").nnoremap
nnoremap("Å", function()
  require("aerial").toggle()
end)
