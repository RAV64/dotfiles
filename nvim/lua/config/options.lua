vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"

local opt = vim.opt

-- GENERAL
opt.autowrite = true -- enable auto write
opt.backup = false
opt.completeopt = "menuone,noselect,fuzzy,nosort"
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep -uu"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.mouse = "a" -- enable mouse mode
opt.scrolloff = 16 -- Lines of context
opt.shada = "'100,<50,s10,:1000,/100,@100,h"
opt.sidescrolloff = 0 -- Columns of context
opt.smoothscroll = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold
opt.writebackup = false

-- UI
opt.breakindent = true -- Indent wrapped lines to match line start
opt.cmdheight = 0
opt.cursorline = true -- Enable highlighting of the current line
opt.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.list = true
opt.listchars = {
	leadmultispace = "│   ",
	tab = "│ ",
	nbsp = "+",
	trail = "·",
	extends = "→",
	precedes = "←",
}
opt.laststatus = 3
opt.number = true -- Print line number
opt.numberwidth = 1 -- tight linenr
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false
opt.shortmess = "CFOSWaco" -- Disable certain messages from |ins-completion-menu|
opt.showmode = false -- dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.winborder = "rounded"
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- Disable line wrap

-- EDITING
opt.expandtab = true -- Spaces instead of tabs
opt.formatoptions = "rqnl1j" -- tcqj
opt.ignorecase = true -- Ignore case
opt.incsearch = true -- Show search results while typing
opt.infercase = true -- Infer letter cases for a richer built-in keyword completion
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'.  Applies to > and <
opt.shiftwidth = 4 -- Spaces for autoindent
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = -1
opt.tabstop = 4 -- Spaces per tab
opt.virtualedit = "block"

-- FOLD
opt.foldenable = false
opt.foldmethod = "manual"
opt.foldlevelstart = 99

vim.g.markdown_recommended_style = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	return keymap_set(mode, lhs, rhs, opts)
end
