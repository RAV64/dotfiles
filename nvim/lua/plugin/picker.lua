local fzf = require("fzf-lua")
local set = vim.keymap.set

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
			layout = "horizontal",
			flip_columns = 120,
			border = "noborder",
		},
		border = "none",
	},

	fzf_opts = {
		["--layout"] = "reverse",
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

set("n", "<leader>f", function()
	fzf.files()
end, { desc = "Open file picker" })

set("n", "<leader>F", function()
	fzf.files({ hidden = true, no_ignore = true })
end, { desc = "Open file picker (ALL)" })

set("n", "<leader>b", function()
	fzf.buffers()
end, { desc = "Open buffer picker" })

set("n", "<leader>j", function()
	fzf.jumps()
end, { desc = "Open jumplist picker" })

set("n", "<leader>s", function()
	fzf.lsp_live_workspace_symbols()
end, { desc = "Open workspace symbol picker (LSP)" })

set("n", "<leader>S", function()
	fzf.lsp_document_symbols()
end, { desc = "Open document symbol picker (LSP)" })

set("n", "<leader>e", function()
	fzf.diagnostics_workspace({ severity_only = "Error" })
end, { desc = "Open errors picker (LSP)" })

set("n", "<leader>d", function()
	fzf.diagnostics_workspace()
end, { desc = "Open workspace diagnostics picker (LSP)" })

set("n", "<leader>l", function()
	fzf.live_grep()
end, { desc = "Global search in workspace folder" })

set("n", "<leader>m", function()
	fzf.marks()
end, { desc = "File Marks" })

set("n", "<leader>o", function()
	fzf.oldfiles()
end, { desc = "Previous files" })

set("n", "<leader>.", function()
	fzf.resume()
end, { desc = "Open last picker (resume)" })

set("n", "<leader>t", function()
	fzf.builtin()
end, { desc = "Fzf-lua builtins" })

set({ "n", "x" }, "<leader>a", function()
	fzf.lsp_code_actions()
end, { desc = "Fzf-lua builtins" })

set("n", "gd", function()
	fzf.lsp_definitions()
end, { desc = "Goto Definition" })

set("n", "gD", function()
	fzf.lsp_declarations()
end, { desc = "Goto Declaration" })

set("n", "gr", function()
	fzf.lsp_references()
end, { desc = "Get Usages/References" })

set("n", "gi", function()
	fzf.lsp_implementations()
end, { desc = "Get implementations" })

set("n", "gt", function()
	fzf.lsp_typedefs()
end, { desc = "Get type definitions" })

set("n", "gu", function()
	fzf.lsp_finder()
end, { desc = "Get usage" })

set("n", "gI", function()
	fzf.lsp_incoming_calls()
end, { desc = "Get incoming calls" })

set("n", "gO", function()
	fzf.lsp_outgoing_calls()
end, { desc = "Get outgoing calls" })

set("n", "<leader><leader>h", function()
	fzf.helptags()
end, { desc = "Find help" })

set("n", "<leader>gs", function()
	fzf.git_status()
end, { desc = "Git status" })

set("n", "<leader>ggb", function()
	fzf.git_branches()
end, { desc = "Git branches" })

set("n", "<leader>ggc", function()
	fzf.git_commits()
end, { desc = "Git commits" })

set("n", "<leader>ggC", function()
	fzf.git_bcommits()
end, { desc = "Git buffer commits" })
