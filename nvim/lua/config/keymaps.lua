local set = vim.keymap.set

local n = "n" -- normal
local x = "x" -- visual
local i = "i" -- insert
local t = "t" -- term
local o = "o"
local nx = { n, x }
local nxo = { n, x, o }

set(n, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set(n, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

set(x, "<", "<gv")
set(x, ">", ">gv")

set(n, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

set(t, "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

set(n, "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set(n, "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set(n, "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set(n, "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

set(n, "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
set(n, "<S-Tab>", "<cmd>bprev<cr>", { desc = "Prev buffer" })

-- undo breakpoints in insert mode
-- set(i, ",", ",<c-g>u")
-- set(i, ".", ".<c-g>u")
-- set(i, ";", ";<c-g>u")

set(i, "<S-Enter>", "<esc>o")

set(nx, "<leader>h", "*N", { desc = "Search word under cursor" })

set(n, "=", "$", { desc = "Go to end of line" })

set(n, "ö", "}")
set(n, "ä", "{")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set(nxo, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set(nxo, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

vim.keymap.set("i", "<esc>", function()
	if vim.snippet.active() then
		vim.snippet.stop()
	end
	return "<esc>"
end, { expr = true })
