local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_map = {
    --LSP
    ["n|,D"]         = map_cr('lua vim.lsp.buf.declaration()'):with_noremap(),
    ["n|,d"]         = map_cr('lua vim.lsp.buf.definition()'):with_noremap(),
    ["n|,a"]         = map_cr('lua vim.lsp.buf.code_action()'):with_noremap(),
    ["n|,l"]         = map_cr('lua vim.lsp.buf.code_lens()'):with_noremap(),
    ["n|,r"]         = map_cr('lua vim.lsp.buf.rename()'):with_noremap(),
    ["n|,i"]         = map_cr('lua vim.lsp.buf.implementation()'):with_noremap(),
    ["n|,f"]         = map_cr('lua vim.lsp.buf.formatting()'):with_noremap(),
    ["n|,h"]         = map_cr('lua vim.lsp.buf.hover()'):with_noremap(),
    ["n|,t"]         = map_cr('lua vim.lsp.buf.type_definition()'):with_noremap(),
    ["n|,e"]         = map_cr('lua vim.diagnostic.get()'):with_noremap(),
    ["n|,n"]         = map_cr('lua vim.lsp.diagnostic.goto_next()'):with_noremap(),
    ["n|,m"]         = map_cr('lua vim.lsp.diagnostic.goto_prev()'):with_noremap(),
    --INSERT
    ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'),
    ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'),
    ["i|<C-l>"]      = map_cmd('<Right>'):with_noremap(),
    ["i|<C-h>"]      = map_cmd('<Left>'):with_noremap(),
    ["i|<C-j>"]      = map_cmd('<Up>'):with_noremap(),
    ["i|<C-k>"]      = map_cmd('<Down>'):with_noremap(),
    ["i|<C-o>"]      = map_cmd('<Esc>o'):with_noremap(),
    --window
    ["n|<space>"]    = map_cmd('<C-w>w'),
    ["n|Q"]          = map_cu('Bdelete'):with_noremap(),
    ["n|wq"]         = map_cmd('<C-w>q'),
    ["n|ww"]         = map_cmd('<C-w>s'),
    ["n|wW"]         = map_cmd('<C-w>v'),
    ["n|wh"]         = map_cmd('<C-w>h'),
    ["n|wj"]         = map_cmd('<C-w>j'),
    ["n|wk"]         = map_cmd('<C-w>k'),
    ["n|wl"]         = map_cmd('<C-w>l'),
    --tabs
    ["n|<Tab>"]      = map_cu('bNext'):with_noremap(),
    ["n|<S-Tab>"]    = map_cu('bprevious'):with_noremap(),
    ["n|te"]         = map_cu('tabedit'):with_noremap(),
    ["n|<C-t>"]      = map_cu('TagbarToggle'):with_noremap(),
    --telescope
    ["n|;L"]          = map_cu('Telescope live_grep'):with_noremap(),
    ["n|;F"]          = map_cu('Telescope file_browser'):with_noremap(),
    ["n|;C"]          = map_cu('Cheatsheet'):with_noremap(),
    --neoscroll
    --keybinds in plugins/neoscroll.lua flder
    --nerdtree
    ["n|;T"]          = map_cu('CHADopen'):with_noremap(),
    --terminal
    ["t|<Esc>"]      = map_cmd('<C-\\><C-n>'),
    ["n|<up>"]       = map_cu('res +1'),
    ["n|<down>"]     = map_cu('res -1'),
    ["n|<right>"]    = map_cu('vertical resize +1'),
    ["n|<left>"]     = map_cu('vertical resize -1'),
}

bind.nvim_load_mapping(def_map)
