vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_user_command("W", function()
	vim.cmd("update")
end, {})

local filetype_group = vim.api.nvim_create_augroup("user-filetype", {})
local function ft(filetypes, callback)
	vim.api.nvim_create_autocmd("FileType", {
		group = filetype_group,
		pattern = filetypes,
		callback = callback,
	})
end

local get_rust_analyzer_clients = function()
	return vim.lsp.get_clients({ name = "rust_analyzer" })
end

local refresh_cargo_workspace = function()
	for client in vim.iter(get_rust_analyzer_clients()) do
		client.request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				vim.notify(tostring(err), vim.log.levels.ERROR)
				return
			end
			vim.notify("Cargo workspace reloaded")
		end)
	end
end

local reload_rust_analyzer = vim.api.nvim_create_augroup("user-reload-rust-analyzer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = reload_rust_analyzer,
	pattern = { "Cargo.toml" },
	callback = function()
		refresh_cargo_workspace()
	end,
})

local update_lead = require("config.util").update_lead()
local update_indent_chars = vim.api.nvim_create_augroup("user-update-indentation-chars", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
	group = update_indent_chars,
	pattern = { "shiftwidth" },
	callback = function()
		update_lead()
	end,
})

local function find_config(config)
	-- Get the parent directory of the current file
	local path = vim.fn.expand("%:p:h:h")

	local function find_config_file(current_path)
		local config_path = current_path .. "/" .. config
		if vim.fn.filereadable(config_path) == 1 then -- If config is found, open it
			vim.cmd("edit " .. config_path)
		else -- Move to the parent directory and search again
			local parent_path = vim.fn.fnamemodify(current_path, ":h")
			if parent_path == current_path then -- If reached the root directory and no config found
				vim.notify(config .. " not found in any parent directories", vim.log.levels.INFO)
			else
				return find_config_file(parent_path)
			end
		end
	end

	-- Start the search from the current file's directory
	find_config_file(path)
end

ft({ "rust", "toml" }, function()
	local fname = vim.fn.expand("%:t")
	if fname == "Cargo.toml" or vim.bo.filetype == "rust" then
		vim.keymap.set("n", "<leader>c", function()
			find_config("Cargo.toml")
		end)
	end
end)

ft({ "rust", "python" }, function()
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
end)

ft({ "lua", "javascript", "javascriptreact", "typescript", "typescriptreact", "json" }, function()
	vim.opt_local.shiftwidth = 2
	vim.opt_local.tabstop = 2
end)

ft({ "markdown" }, function()
	vim.opt_local.linebreak = true
	vim.opt_local.wrap = true
end)

local macro_cursorline_group = vim.api.nvim_create_augroup("user-macro-visual-indication", { clear = true })
vim.api.nvim_create_autocmd("RecordingEnter", {
	group = macro_cursorline_group,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#603717" })
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = macro_cursorline_group,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#393939" })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function()
		local set = vim.keymap.set

		set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
		set("n", "gD", vim.lsp.buf.declaration, { desc = "Get Declaration" })
		set("n", "Z", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostics" })
		set("n", "z", vim.diagnostic.goto_next, { desc = "Goto next diagnostics" })
		set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostics" })
		set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature" })
		set("n", "<leader>gwa", vim.lsp.buf.add_workspace_folder, { desc = "add_workspace_folder" })
		set("n", "<leader>gwr", vim.lsp.buf.remove_workspace_folder, { desc = "remove_workspace_folder" })
		set("n", "<leader>gwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "list_workspace_folders" })
	end,
})
