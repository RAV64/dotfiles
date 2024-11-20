local tb_f = function(f, args)
	return function()
		UTIL.func("telescope.builtin", f, args)
	end
end
local M = {}

M.symbol_highlights = {
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

M.plugin = {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		keys = {
			{ "<leader>f", tb_f("find_files"), desc = "Open file picker" },
			{ "<leader>F", tb_f("find_files", { hidden = true, no_ignore = true }), desc = "Open file picker (ALL)" },
			{ "<leader>b", tb_f("buffers"), desc = "Open buffer picker" },
			{ "<leader>j", tb_f("jumplist"), desc = "Open jumplist picker" },
			{ "<leader>s", tb_f("lsp_dynamic_workspace_symbols"), desc = "Open workspace symbol picker (LSP)" },
			{ "<leader>S", tb_f("lsp_document_symbols"), desc = "Open document symbol picker (LSP)" },
			{ "<leader>e", tb_f("diagnostics", { severity = "error" }), desc = "Open workspace errors picker (LSP)" },
			{ "<leader>d", tb_f("diagnostics"), desc = "Open workspace diagnostics picker (LSP)" },
			{ "<leader>l", tb_f("live_grep"), desc = "Global search in workspace folder" },
			{ "<leader>m", tb_f("marks"), desc = "File Marks" },
			{ "<leader>o", tb_f("oldfiles"), desc = "Previous files" },
			{ "<leader>.", tb_f("resume"), desc = "Open last builtin picker" },
			{ "<leader>t", tb_f("builtin"), desc = "Telescope builtins" },

			{ "gd", tb_f("lsp_definitions"), desc = "Goto Definition" },
			{ "gr", tb_f("lsp_references"), desc = "Get Usages" },
			{ "gi", tb_f("lsp_implementations"), desc = "Get implementations" },
			{ "gt", tb_f("lsp_type_definitions"), desc = "Get type definitions" },

			{ "<leader>vs", tb_f("git_status"), desc = "Git status" },
			{ "<leader>gh", tb_f("help_tags"), desc = "Find Help" },
		},
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				pickers = {
					lsp_dynamic_workspace_symbols = {
						symbol_highlights = M.symbol_highlights,
						path_display = { "hidden" },
					},
				},
				defaults = {
					borderchars = { " ", "", "", "", "", "", "", "" },
					initial_mode = "insert",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
						width = 0.95,
						height = 0.95,
						preview_cutoff = 10,
					},
					layout_strategy = "horizontal",
					mappings = {
						n = {
							["q"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
					reuse_win = true,
					path_display = { "truncate" },
					prompt_prefix = "  ",
					selection_caret = " ",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					results_title = false,
					dynamic_preview_title = true,
				},
			})

			require("telescope").load_extension("fzf")
		end,
	},
}

return M.plugin
