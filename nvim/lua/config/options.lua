vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- enable auto write
opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.cmdheight = 0
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.mouse = "a" -- enable mouse mode
opt.number = true -- Print line number
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 1 -- tight linenr
opt.scrolloff = 16 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "winsize" }
opt.shortmess:append({
	W = true, -- Don't print "written" when editing
	I = true, -- No splash screen
	c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
	C = true, -- Don't show messages while scannign ins-completion items (scanning tags)
	s = true, -- Don't show "Search hit BOTTOM" message
})
opt.showmode = false -- dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.undofile = true
opt.swapfile = false
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- Disable line wrap
opt.ruler = false
-- opt.smoothscroll = true -- TODO 0.10

opt.shiftround = true
opt.softtabstop = -1
opt.virtualedit = "block"
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.list = true
opt.listchars = {
	leadmultispace = "│   ",
	tab = "│ ",
	nbsp = "+",
	trail = "·",
	extends = "→",
	precedes = "←",
}

vim.g.neo_tree_remove_legacy_commands = 1
vim.g.markdown_recommended_style = 0
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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
