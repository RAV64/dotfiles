vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- enable auto write
opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
opt.cmdheight = 0
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3
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
opt.sidescrolloff = 0 -- Columns of context
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
opt.smoothscroll = true

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

opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	eob = " ",
}

vim.g.neo_tree_remove_legacy_commands = 1
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

-- local function add_inline_highlights(buf)
-- 	for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
-- 		for pattern, hl_group in pairs({
-- 			["@%S+"] = "@parameter",
-- 			["^%s*(Parameters:)"] = "@text.title",
-- 			["^%s*(Return:)"] = "@text.title",
-- 			["^%s*(See also:)"] = "@text.title",
-- 			["{%S-}"] = "@parameter",
-- 			["|%S-|"] = "@text.reference",
-- 		}) do
-- 			local from = 1 ---@type integer?
-- 			while from do
-- 				local to
-- 				from, to = line:find(pattern, from)
-- 				if from then
-- 					vim.api.nvim_buf_set_extmark(
-- 						buf,
-- 						vim.api.nvim_create_namespace("rav64/lsp_float"),
-- 						l - 1,
-- 						from - 1,
-- 						{
-- 							end_col = to,
-- 							hl_group = hl_group,
-- 						}
-- 					)
-- 				end
-- 				from = to and to + 1 or nil
-- 			end
-- 		end
-- 	end
-- end
--
-- local function enhanced_float_handler(handler, focusable)
-- 	return function(err, result, ctx, config)
-- 		local bufnr, winnr = handler(err, result, ctx, config)
--
-- 		if not bufnr or not winnr then
-- 			return
-- 		end
--
-- 		-- Conceal everything.
-- 		vim.wo[winnr].concealcursor = "n"
--
-- 		-- Extra highlights.
-- 		add_inline_highlights(bufnr)
--
-- 		-- Add keymaps for opening links.
-- 		if focusable and not vim.b[bufnr].markdown_keys then
-- 			vim.keymap.set("n", "K", function()
-- 				-- Vim help links.
-- 				local url = (vim.fn.expand("<cWORD>") --[[@as string]]):match("|(%S-)|")
-- 				if url then
-- 					return vim.cmd.help(url)
-- 				end
--
-- 				-- Markdown links.
-- 				local col = vim.api.nvim_win_get_cursor(0)[2] + 1
-- 				local from, to
-- 				from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
-- 				if from and col >= from and col <= to then
-- 					vim.system({ "open", url }, nil, function(res)
-- 						if res.code ~= 0 then
-- 							vim.notify("Failed to open URL" .. url, vim.log.levels.ERROR)
-- 						end
-- 					end)
-- 				end
-- 			end, { buffer = bufnr, silent = true })
-- 			vim.b[bufnr].markdown_keys = true
-- 		end
-- 	end
-- end
--
-- vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover, true)
-- vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_signatureHelp] =
-- 	enhanced_float_handler(vim.lsp.handlers.signature_help, false)
--
-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
-- 	contents = vim.lsp.util._normalize_markdown(contents, {
-- 		width = vim.lsp.util._make_floating_popup_size(contents, opts),
-- 	})
-- 	vim.bo[bufnr].filetype = "markdown"
-- 	vim.treesitter.start(bufnr)
-- 	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
--
-- 	add_inline_highlights(bufnr)
--
-- 	return contents
-- end
