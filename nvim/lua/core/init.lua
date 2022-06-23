local load_core = function()
	require("core.packer")
	require("plugins.lsp")
	require("plugins.treesitter")
	require("plugins.completion")
	require("plugins.nav")
	require("plugins.ui")
	require("plugins.misc")
	require("core.settings")
	require("core.keymaps")
	require("core.commands")
end

load_core()
