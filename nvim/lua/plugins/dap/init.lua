local dap_status, dap = pcall(require, "dap")
if not dap_status then
	vim.notify("Please Install 'nvim-dap'")
	return
end

--require("plugins.dap.settings.rust")
require("plugins.dap.settings.python")

dap.defaults.fallback.terminal_win_cmd = "80vsplit new"
vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "", linehl = "dapBreakpoint", numhl = "dapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "dapStopped", numhl = "dapStopped" })

local nvim_dap_ui_status, dapui = pcall(require, "dapui")
if not nvim_dap_ui_status then
	vim.notify("Please Install 'nvim-dap-ui'")
	return
end
dapui.setup()

local nvim_dap_virtual_text_status, nvim_dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not nvim_dap_virtual_text_status then
	vim.notify("Please Install 'nvim-dap-virtual-text'")
	return
end

nvim_dap_virtual_text.setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,

	virt_text_pos = "eol",
	all_frames = true,
	virt_lines = false,
	virt_text_win_col = nil,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
