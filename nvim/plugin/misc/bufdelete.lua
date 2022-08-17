local status, _ = pcall(require, 'bufdelete')
if not status then
  print('ERROR: bufdelete')
  return
end

local nnoremap = require("rav64.keymaps").nnoremap

nnoremap("<S-q>", function()
	require("bufdelete").bufdelete(0)
end)
