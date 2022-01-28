local load_core = function()
  require('core.pack')
  require('core.plugin_installer')
  require('plugins')
  require('core.settings')
  require('core.keymaps')
  vim.cmd[[ autocmd VimEnter * CHADopen ]]
end

load_core()
