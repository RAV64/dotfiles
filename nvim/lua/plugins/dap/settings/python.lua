local dap_status, dap = pcall(require, "dap")
if not dap_status then
	vim.notify("Please Install 'nvim-dap'")
	return
end

dap.configurations.python = {
	{

		type = "python",
		request = "launch",
		name = "Launch file",

		program = "${file}",
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin/python3"
			end
		end,
	},
}

dap.adapters.python = {
	type = "executable",
	command = "~/.virtualenvs/debugpy/bin/python",
	args = { "-m", "debugpy.adapter" },
}
