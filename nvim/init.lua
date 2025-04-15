_G.UTIL = require("config.util")

require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.opt.clipboard = "unnamedplus"
		require("config.colors")
		require("config.keymaps")
		require("config.autocmds")
		require("mod.statusline")
		require("mod.autopair")
		require("mod.puff-buff")
		require("mod.surround")
		require("mod.treesitter-matchit")
		require("mod.lsp")

		-- require("mod.treesitter-diagnostics")
	end,
})

-- https://github.com/folke/lazy.nvim - Apache-2.0 - Package manager
-- https://github.com/MagicDuck/grug-far.nvim/tree/3bc6997724c6b9c10bc4bac86821c9061694ded3 - MIT - Search and replace
-- https://github.com/Saghen/blink.cmp/tree/cb5e346d9e0efa7a3eee7fd4da0b690c48d2a98e - MIT - Autocompletion
-- https://github.com/echasnovski/mini.files/tree/432142ada983ec5863ba480f0e4891b7d64ce3f6 - MIT - File browser
-- https://github.com/echasnovski/mini.icons/tree/397ed3807e96b59709ef3292f0a3e253d5c1dc0a - MIT - Icon provider
-- https://github.com/folke/flash.nvim/tree/3c942666f115e2811e959eabbdd361a025db8b63 - Apache-2.0 - Code navigation helper
-- https://github.com/ibhagwan/fzf-lua/tree/970fc983b887cead7d630e062fed01337e41b25d - MIT - Fuzzy finder (Search files, text, classes, etc..)
-- https://github.com/j-hui/fidget.nvim/tree/d9ba6b7bfe29b3119a610892af67602641da778e - MIT - Notifications
-- https://github.com/jake-stewart/multicursor.nvim/tree/f3a4899e5cdc93e6f8cd06bbc3b3631a2e85a315 - MIT - Multiple cursors
-- https://github.com/lewis6991/gitsigns.nvim/tree/fcfa7a989cd6fed10abf02d9880dc76d7a38167d - MIT - Git integration
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/fa32a45fdbab9c9c3bda9ecec9b12dddb221b927 - Apache-2.0 - Treesitter text objects (Delete inside function, Delete around class, etc..)
-- https://github.com/nvim-treesitter/nvim-treesitter/tree/ae32ed8bda5e78d00aaa99300cf2f1c45ce1884c - Apacha-2.0 - Treesitter syntax highlighting
-- https://github.com/stevearc/conform.nvim/tree/eebc724d12c5579d733d1f801386e0ceb909d001 - MIT - Formatter adapter
-- https://github.com/xzbdmw/colorful-menu.nvim/tree/f80feb8a6706f965321aff24d0ed3849f02a7f77 - MIT - Syntax highlighting in autocompletion
