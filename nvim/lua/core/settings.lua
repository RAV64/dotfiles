local function set_settings(options, bw_options)
  for name, value in pairs(options) do
    vim.o[name] = value
  end

  for k, v in pairs(bw_options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_settings()
  local global_local = {
    backup         = false;
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    backspace      = "start,eol,indent";
    cmdheight      = 2;
    cmdwinheight   = 5;
    cursorline     = true;
    display        = "lastline";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    encoding       = "utf-8";
    fileencodings  = "utf-8,sjis,euc-jp,latin";
    foldminlines   = 3;
    foldnestmax    = 1;
    foldmethod     = "expr";
    foldexpr       = "nvim_treesitter#foldexpr()";
    hidden         = true;
    ignorecase     = true;
    laststatus     = 2;
    list           = true;
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    number         = true;
    relativenumber = true;
    numberwidth    = 2;
    ruler          = false;
    smartcase      = true;
    smarttab       = true;
    scrolloff      = 18;
    sidescrolloff  = 18;
    syntax         = false;
    shada          = "!,'300,<50,@100,s10,h";
    showcmd        = false;
    showbreak      = "↳  ";
    showmatch      = true;
    title          = true;
    termguicolors  = true;
    viewoptions    = "folds,cursor,curdir,slash,unix";
    wildignorecase = true;
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
  }

  local bw_local   = {
    undofile       = true;
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    textwidth      = 80;
    expandtab      = true;
    autoindent     = true;
    smartindent    = true;
    tabstop        = 2;
    shiftwidth     = 2;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    wrap           = false;
    linebreak      = true;
    number         = true;
    colorcolumn    = "80";
    foldenable     = false;
    signcolumn     = "yes";
    conceallevel   = 2;
    concealcursor  = "niv";
  }

  vim.g.clipboard = {
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0
  }

  vim.g.python3_host_prog = '/opt/homebrew/opt/python@3.10/bin/python3'

  set_settings(global_local, bw_local)

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
