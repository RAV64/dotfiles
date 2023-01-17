local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap
local inoremap = remap.inoremap
local tnoremap = remap.tnoremap

local function set_settings(options, bw_options)
	for name, value in pairs(options) do
		vim.o[name] = value
	end

	for k, v in pairs(bw_options) do
		if v == true or v == false then
			vim.cmd("set " .. k)
		else
			vim.cmd("set " .. k .. "=" .. v)
		end
	end
end

local function load_settings()
	local options = {
		backspace = "start,eol,indent",
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		clipboard = "unnamedplus",
		cmdheight = 0,
		cmdwinheight = 5,
		cursorline = true,
		diffopt = "filler,iwhite,internal,algorithm:patience",
		display = "lastline",
		encoding = "utf-8",
		fileencodings = "utf-8,sjis,euc-jp,latin",
		hidden = true,
		ignorecase = true,
		list = true,
		listchars = "tab:  ,nbsp:+,trail:·,extends:→,precedes:←",
		mouse = "a",
		number = true,
		numberwidth = 2,
		relativenumber = true,
		ruler = true,
		scrolloff = 8,
		shada = "!,'300,<50,@100,s10,h",
		showbreak = "↳  ",
		showcmd = false,
		showmatch = true,
		sidescrolloff = 8,
		smartcase = true,
		smartindent = true,
		termguicolors = true,
		title = true,
		viewoptions = "folds,cursor,curdir,slash,unix",
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,**/node_modules/**,**/bower_modules/**",
		wildignorecase = true,
	}

	local bw_local = {
		breakindentopt = "shift:2,min:20",
		colorcolumn = "80",
		foldenable = true,
		foldexpr = "nvim_treesitter#foldexpr()",
		foldlevelstart = 99,
		foldmethod = "expr",
		formatoptions = "1jcroql",
		hlsearch = false,
		incsearch = true,
		linebreak = true,
		nowrap = true,
		number = true,
		shiftwidth = 2,
		signcolumn = "yes",
		synmaxcol = 2500,
		textwidth = 80,
	}

	vim.g.python3_host_prog = "/opt/homebrew/opt/python@3.10/bin/python3"
	vim.opt.shortmess:append("c")
	vim.opt.isfname:append("@-@")
	vim.opt.updatetime = 50

	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = true

	vim.opt.swapfile = false
	vim.opt.backup = false

	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
	vim.opt.undofile = true
	vim.o.breakindent = true
	vim.o.completeopt = 'menuone,noselect'

	set_settings(options, bw_local)
end

load_settings()

local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

inoremap("jj", "<Esc>")
inoremap("jk", "<Esc>")
inoremap("kk", "<Esc>")
inoremap("<S-Tab>", "<Esc>Ea")
inoremap("<S-CR>", "<Esc>o")

nnoremap("<leader>ww", ":vsplit<CR>")
nnoremap("<leader>ws", ":split<CR>")
nnoremap("<leader>wq", ":q<CR>")
nnoremap("<leader>h", "<C-w>h")
nnoremap("<leader>j", "<C-w>j")
nnoremap("<leader>k", "<C-w>k")
nnoremap("<leader>l", "<C-w>l")

tnoremap("<Esc>", "<C-\\><C-n>")

nnoremap("ö", "}")
nnoremap("ä", "{")
