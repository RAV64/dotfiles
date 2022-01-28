local load_core = function()
  require('core.pack')
  require('core.plugin_installer')
  require('plugins')
  require('core.settings')
  require('core.keymaps')
end

load_core()
