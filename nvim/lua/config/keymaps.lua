local set = vim.keymap.set

local n = "n" -- normal
local x = "x" -- visual
local i = "i" -- insert
local t = "t" -- term
local o = "o"
local nx = { n, x }
local ni = { n, i }
local nxo = { n, x, o }

set(n, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set(n, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

set(ni, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

set(x, "<", "<gv")
set(x, ">", ">gv")

set(n, "<C-l>", "<cmd>:Lazy<cr>", { desc = "Lazy" })

set(n, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

set(t, "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

set(n, "<leader>h", "<C-w>h", { desc = "Go to left window" })
set(n, "<leader>j", "<C-w>j", { desc = "Go to lower window" })
set(n, "<leader>k", "<C-w>k", { desc = "Go to upper window" })
set(n, "<leader>l", "<C-w>l", { desc = "Go to right window" })

set(n, "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
set(n, "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
set(n, "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set(n, "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- undo breakpoints in insert mode
set(i, ",", ",<c-g>u")
set(i, ".", ".<c-g>u")
set(i, ";", ";<c-g>u")

set(i, "<S-Enter>", "<esc>o")

set(nx, "gw", "*N", { desc = "Search word under cursor" })

set(n, "=", "$", { desc = "Go to end of line" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set(nxo, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set(nxo, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
