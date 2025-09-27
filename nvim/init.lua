_G.UTIL = require("config.util")

require("config.options")
require("config.plugins")
require("vim._extui").enable({})

vim.opt.clipboard = "unnamedplus"
require("config.colors")
require("config.keymaps")
require("config.autocmds")

require("plugin.misc")
require("plugin.treesitter")

require("plugin.cmp")
require("plugin.conform")
require("plugin.gitsigns")
require("plugin.grug-far")
require("plugin.multicursor")
require("plugin.picker")

require("mod.statusline")
require("mod.autopair")
require("mod.puff-buff")
require("mod.surround")
require("mod.treesitter-matchit")
require("mod.treesitter-diagnostics")
require("mod.lsp")
require("mod.quick-term")
require("mod.smart-tab")
