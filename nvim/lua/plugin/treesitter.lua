local treesitter = require("nvim-treesitter")
local set = vim.keymap.set

treesitter.setup({
	ensure_install = { "community" },
	ignore_install = { "unsupported" },
	indent = { enable = true },
	highlights = { enable = true },
	folds = { enable = true },
})

local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
local pattern = UTIL.get_top_level_keys(require("nvim-treesitter.parsers"))

vim.api.nvim_create_autocmd("FileType", {
	pattern = pattern,
	group = group,
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		pcall(vim.treesitter.start)
	end,
})

local ntts = function(tx)
	local module = require("nvim-treesitter-textobjects.select")
	return function()
		module.select_textobject(tx, "textobjects")
	end
end

set({ "x", "o" }, "if", ntts("@function.inner"))
set({ "x", "o" }, "af", ntts("@function.outer"))
set({ "x", "o" }, "it", ntts("@class.inner"))
set({ "x", "o" }, "at", ntts("@class.outer"))
