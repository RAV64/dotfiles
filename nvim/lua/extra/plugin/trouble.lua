return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	opts = {
		use_diagnostic_signs = true,
		position = "right",
	},
	keys = {
		{ "<leader>tf", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
		{ "<leader>tt", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		{ "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
		{ "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
	},
}
