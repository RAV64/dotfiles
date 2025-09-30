local function r(module)
	local status_ok, loaded_module = pcall(require, module)
	if not status_ok then
		vim.notify("Error loading " .. module, vim.log.levels.ERROR)
		vim.notify(loaded_module, vim.log.levels.ERROR)
	end
	return loaded_module
end

_G.UTIL = r("config.util")

r("config.options")
r("config.plugins")
r("vim._extui").enable({})

r("config.colors")
r("config.keymaps")
r("config.autocmds")

r("plugin.misc")
r("plugin.treesitter")

r("plugin.cmp")
r("plugin.conform")
r("plugin.gitsigns")
r("plugin.grug-far")
r("plugin.multicursor")
r("plugin.picker")

r("mod.statusline")
r("mod.autopair")
r("mod.puff-buff")
r("mod.surround")
r("mod.treesitter-matchit")
r("mod.treesitter-diagnostics")
r("mod.lsp")
r("mod.quick-term")
r("mod.smart-tab")
