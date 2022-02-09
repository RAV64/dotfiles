local dap_status, dap = pcall(require, "dap")
if not dap_status then
	vim.notify("Please Install 'nvim-dap'")
	return
end

local extension_path = "/Users/miki/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

local opts = {
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
	autoSetHints = true,
	runnables = {
		use_telescope = true,
	},
	inlay_hints = {
		show_parameter_hints = true,
		server = {
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						enable = true,
						command = "check",
						extraArgs = {
							{ "--target-dir", "/tmp/rust-analyzer-check" },
						},
					},
				},
			},
		},
	},
}

require("rust-tools").setup(opts)

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
}
