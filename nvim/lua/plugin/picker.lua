local f = function(f, args)
	return function()
		UTIL.func("fzf-lua", f, args)
	end
end

local M = {}

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

M.plugin = {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	keys = {
		{ "<leader>f", f("files"), desc = "Open file picker" },
		{ "<leader>F", f("files", { hidden = true, no_ignore = true }), desc = "Open file picker (ALL)" },
		{ "<leader>b", f("buffers"), desc = "Open buffer picker" },
		{ "<leader>j", f("jumps"), desc = "Open jumplist picker" },
		{ "<leader>s", f("lsp_live_workspace_symbols"), desc = "Open workspace symbol picker (LSP)" },
		{ "<leader>S", f("lsp_document_symbols"), desc = "Open document symbol picker (LSP)" },
		{ "<leader>e", f("diagnostics_workspace", { severity_only = "Error" }), desc = "Open errors picker (LSP)" },
		{ "<leader>d", f("diagnostics_workspace"), desc = "Open workspace diagnostics picker (LSP)" },
		{ "<leader>l", f("live_grep"), desc = "Global search in workspace folder" },
		{ "<leader>m", f("marks"), desc = "File Marks" },
		{ "<leader>o", f("oldfiles"), desc = "Previous files" },
		{ "<leader>.", f("resume"), desc = "Open last picker (resume)" },
		{ "<leader>t", f("builtin"), desc = "Fzf-lua builtins" },
		{ "<leader>a", f("lsp_code_action"), desc = "Fzf-lua builtins" },
		{ "gd", f("lsp_definitions"), desc = "Goto Definition" },
		{ "gD", f("lsp_declarations"), desc = "Goto Declaration" },
		{ "gr", f("lsp_references"), desc = "Get Usages/References" },
		{ "gi", f("lsp_implementations"), desc = "Get implementations" },
		{ "gt", f("lsp_typedefs"), desc = "Get type definitions" },
		{ "gI", f("lsp_incoming_calls"), desc = "Get incoming calls" },
		{ "gO", f("lsp_outgoing_calls"), desc = "Get outgoing calls" },
		{ "<leader>vs", f("git_status"), desc = "Git status" },
		{ "<leader>gh", f("helptags"), desc = "Find help" },
	},
	opts = {
		winopts = {
			height = 0.95,
			width = 0.95,
			preview = {
				layout = "horizontal",
				flip_columns = 120,
			},
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
	},
}

return M.plugin
