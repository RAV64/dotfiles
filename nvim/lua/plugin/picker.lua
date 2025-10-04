local fzf = require("fzf-lua")
fzf.register_ui_select()

local symbol_highlights = {
	Class = "Class",
	Color = "Color",
	Constant = "Constant",
	Constructor = "Constructor",
	Enum = "Enum",
	EnumMember = "EnumMember",
	Event = "Event",
	Field = "Field",
	File = "File",
	Folder = "Folder",
	Function = "Function",
	Interface = "Interface",
	Keyword = "Keyword",
	Method = "Method",
	Module = "Module",
	Operator = "Operator",
	Property = "Property",
	Reference = "Reference",
	Snippet = "Snippet",
	Struct = "Struct",
	Text = "Text",
	TypeParameter = "Type",
	Unit = "Unit",
	Value = "Value",
	Variable = "Variable",
}

local function symbol_hl_func(kind)
	return symbol_highlights[kind] or "Normal"
end

fzf.setup({
	winopts = {
		height = 0.95,
		width = 0.95,
		preview = {
			layout = "vertical",
			vertical = "down:75%",
			flip_columns = 120,
			border = "noborder",
		},
		border = "none",
	},

	fzf_opts = {
		["--prompt"] = "  ",
	},

	keymap = {
		builtin = {
			["<C-j>"] = "down",
			["<C-k>"] = "up",
		},
	},

	lsp = {
		symbols = {
			symbol_hl = symbol_hl_func,
		},
	},
})

local set = vim.keymap.set

set("n", "<leader>f", fzf.files, { desc = "Open file picker" })
set("n", "<leader>b", fzf.buffers, { desc = "Open buffer picker" })
set("n", "<leader>j", fzf.jumps, { desc = "Open jumplist picker" })

set("n", "<leader>d", fzf.diagnostics_workspace, { desc = "Open workspace diagnostics picker (LSP)" })
set("n", "<leader>e", function()
	fzf.diagnostics_workspace({ severity_only = "Error" })
end, { desc = "Open errors picker (LSP)" })

set("n", "<leader>l", fzf.live_grep_native, { desc = "Global search in workspace folder" })
set("n", "<leader>m", fzf.marks, { desc = "File Marks" })
set("n", "<leader>o", fzf.oldfiles, { desc = "Previous files" })
set("n", "<leader>.", fzf.resume, { desc = "Open last picker (resume)" })
set("n", "<leader>t", fzf.builtin, { desc = "Fzf-lua builtins" })

set("n", "<leader>s", fzf.treesitter, { desc = "Open document symbol picker (treesitter)" })
set("n", "<leader>S", fzf.lsp_live_workspace_symbols, { desc = "Open workspace symbol picker (LSP)" })
set({ "n", "x" }, "<leader>a", fzf.lsp_code_actions, { desc = "Fzf-lua builtins" })
set("n", "gd", fzf.lsp_definitions, { desc = "Goto Definition" })
set("n", "gD", fzf.lsp_declarations, { desc = "Goto Declaration" })
set("n", "gr", fzf.lsp_references, { desc = "Get Usages/References" })
set("n", "gi", fzf.lsp_implementations, { desc = "Get implementations" })
set("n", "gt", fzf.lsp_typedefs, { desc = "Get type definitions" })
set("n", "gu", fzf.lsp_finder, { desc = "Get usage" })
set("n", "gI", fzf.lsp_incoming_calls, { desc = "Get incoming calls" })
set("n", "gO", fzf.lsp_outgoing_calls, { desc = "Get outgoing calls" })

set("n", "<leader><leader>h", fzf.helptags, { desc = "Find help" })

set("n", "<leader>gs", fzf.git_status, { desc = "Git status" })
set("n", "<leader>gB", fzf.git_branches, { desc = "Git branches" })
set("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
set("n", "<leader>gC", fzf.git_bcommits, { desc = "Git buffer commits" })
