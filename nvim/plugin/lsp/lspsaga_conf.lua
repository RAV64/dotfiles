local status, lspsaga = pcall(require, "lspsaga")
if not status then
	print("ERROR: lspsaga")
	return
end

local kind = require("lspsaga.lspkind")
kind[1][2] = " "
kind[2][2] = " "
kind[5][2] = "ﴯ "
kind[6][2] = " "
kind[7][2] = "ﰠ "
kind[9][2] = " "
kind[11][2] = " "
kind[12][2] = " "
kind[13][2] = " "
kind[14][2] = " "
kind[15][2] = " "
kind[16][2] = " "
kind[20][2] = " "
kind[22][2] = " "

lspsaga.init_lsp_saga({
	symbol_in_winbar = { in_custom = true, enable = true, separator = " > " },
	max_preview_lines = 20,
	finder_action_keys = {
		open = "<CR>",
		vsplit = "s",
		split = "w",
		tabe = "t",
		quit = { "q", "<Esc>" },
		scroll_down = "<C-j>",
		scroll_up = "<C-k>",
	},
	show_outline = {
		virt_text = "┃",
		win_position = "right",
		auto_refresh = true,
		jump_key = "<CR>",
	},
})

local function get_file_name(include_path)
	local file_name = require("lspsaga.symbolwinbar").get_file_name()
	if vim.fn.bufname("%") == "" then
		return ""
	end
	if include_path == false then
		return file_name
	end
	-- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
	local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
	local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
	local file_path = ""
	for _, cur in ipairs(path_list) do
		file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. "%#LspSagaWinbarSep#/%*" .. "%*"
	end
	return file_path .. file_name
end

local function config_winbar()
	local exclude = {
		["teminal"] = true,
		["toggleterm"] = true,
		["prompt"] = true,
		["NvimTree"] = true,
		["help"] = true,
	} -- Ignore float windows and exclude filetype
	if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
		vim.wo.winbar = ""
	else
		local ok, lspsaga_symbolwinbar = pcall(require, "lspsaga.symbolwinbar")
		local sym
		if ok then
			sym = lspsaga_symbolwinbar.get_symbol_node()
		end
		local win_val = ""
		win_val = get_file_name(true) -- set to true to include path
		if sym ~= nil then
			win_val = win_val .. sym
		end
		vim.wo.winbar = win_val
	end
end

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

vim.api.nvim_create_autocmd(events, {
	pattern = "*",
	callback = function()
		config_winbar()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LspsagaUpdateSymbol",
	callback = function()
		config_winbar()
	end,
})
