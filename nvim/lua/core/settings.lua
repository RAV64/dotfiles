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
		backup = false,
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		backspace = "start,eol,indent",
		cmdheight = 1,
		cmdwinheight = 5,
		clipboard = "unnamedplus",
		completeopt = "menuone,noselect",
		cursorline = true,
		display = "lastline",
		diffopt = "filler,iwhite,internal,algorithm:patience",
		encoding = "utf-8",
		fileencodings = "utf-8,sjis,euc-jp,latin",
		--foldminlines   = 3;
		--foldnestmax    = 1;
		--foldmethod     = "expr";
		--foldexpr       = "nvim_treesitter#foldexpr()";
		hidden = true,
		mouse = "a",
		ignorecase = true,
		list = true,
		listchars = "tab:  ,nbsp:+,trail:·,extends:→,precedes:←",
		number = true,
		relativenumber = true,
		numberwidth = 2,
		ruler = true,
		smartcase = true,
		smartindent = true,
		smarttab = true,
		scrolloff = 8,
		sidescrolloff = 8,
		syntax = false,
		shada = "!,'300,<50,@100,s10,h",
		showcmd = false,
		showbreak = "↳  ",
		showmatch = true,
		title = true,
		termguicolors = true,
		viewoptions = "folds,cursor,curdir,slash,unix",
		wildignorecase = true,
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
        winbar = "%f"
	}

	local bw_local = {
		--mapleader      = ' ';
		--maplocalleader = ' ';
		undofile = true,
		synmaxcol = 2500,
		formatoptions = "1jcroql",
		textwidth = 80,
		expandtab = true,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 4,
		breakindentopt = "shift:2,min:20",
		nowrap = true,
		linebreak = true,
		number = true,
		colorcolumn = "80",
		foldenable = false,
		signcolumn = "yes",
		conceallevel = 2,
		concealcursor = "niv",
		hlsearch = false,
		incsearch = true,
	}

	vim.g.python3_host_prog = "/opt/homebrew/opt/python@3.10/bin/python3"
	vim.opt.shortmess:append("c")
	vim.opt.isfname:append("@-@")
	vim.opt.updatetime = 50
	vim.g.mapleader = " "

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
