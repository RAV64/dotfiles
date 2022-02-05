local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local def_map = {
    --LSP
    ["n|gD"]         = map_cr('Lspsaga lsp_finder'):with_noremap(),
    ["n|gd"]         = map_cr('lua vim.lsp.buf.definition()'):with_noremap(),
    ["n|ga"]         = map_cr('Lspsaga code_action'):with_noremap(),
    ["n|gs"]         = map_cr('Lspsaga signature'):with_noremap(),
    ["n|gr"]         = map_cr('Lspsaga rename'):with_noremap(),
    ["n|gi"]         = map_cr('lua vim.lsp.buf.implementation()'):with_noremap(),
    ["n|gf"]         = map_cr('lua vim.lsp.buf.formatting()'):with_noremap(),
    ["n|gh"]         = map_cr('Lspsaga hover_doc'):with_noremap(),
    ["n|gt"]         = map_cr('lua vim.lsp.buf.type_definition()'):with_noremap(),
    ["n|ge"]         = map_cr('Lspsaga show_line_diagnostics'):with_noremap(),
    ["n|gn"]         = map_cr('Lspsaga diagnostic_jump_next'):with_noremap(),
    ["n|gm"]         = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap(),
    ["n|<C-t>"]      = map_cr('Lspsaga toggle_floaterm'):with_noremap(),
    --INSERT
    ["i|<S-Tab>"]    = map_cmd('<Esc>Ea'),
    ["i|jj"]         = map_cmd('<Esc>'),
    ["i|jk"]         = map_cmd('<Esc>'),
    ["i|<C-l>"]      = map_cmd('<Right>'):with_noremap(),
    ["i|<C-h>"]      = map_cmd('<Left>'):with_noremap(),
    ["i|<C-j>"]      = map_cmd('<Up>'):with_noremap(),
    ["i|<C-k>"]      = map_cmd('<Down>'):with_noremap(),
    ["i|<C-o>"]      = map_cmd('<Esc>o'):with_noremap(),
    --window<Plug>(cmp.u.k.recursive: )
    ["n|<space>"]    = map_cmd('<C-w>w'),
    ["n|Q"]          = map_cu('Bdelete'):with_noremap(),
    ["n|wq"]         = map_cmd('<C-w>q'),
    ["n|ww"]         = map_cmd('<C-w>s'),
    ["n|wW"]         = map_cmd('<C-w>v'),
    ["n|wh"]         = map_cmd('<C-w>h'),
    ["n|wj"]         = map_cmd('<C-w>j'),
    ["n|wk"]         = map_cmd('<C-w>k'),
    ["n|wl"]         = map_cmd('<C-w>l'),
    ["i|<C-f>"]      = map_cmd('<Esc><leader><leader>s'),
    --tabs
    ["n|<Tab>"]      = map_cmd('w'),
    ["n|<S-Tab>"]    = map_cu('bNext'):with_noremap(),
    ["n|te"]         = map_cu('tabedit'):with_noremap(),
    --telescope
    ["n|fl"]          = map_cu('Telescope live_grep'):with_noremap(),
    ["n|fs"]          = map_cu('Telescope grep_string'):with_noremap(),
    ["n|ff"]          = map_cu('Telescope find_files'):with_noremap(),
    ["n|fF"]          = map_cu('Telescope file_browser'):with_noremap(),
    ["n|fc"]          = map_cu('Cheatsheet'):with_noremap(),
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
