local M = {}

function M.post()
	require("dapui").setup({
		sidebar = { size = 40 },
		tray = { size = 10 },
		floating = { max_width = 0.9, max_height = 0.5, border = vim.g.border_chars },
	})

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = "🔥", texthl = "dapBreakpoint", linehl = "dapBreakpoint", numhl = "dapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = "⭐️", texthl = "dapStopped", linehl = "dapStopped", numhl = "dapStopped" }
	)

	local dap = require("dap")

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
		command = "/Users/miki/.virtualenvs/debugpy/bin/python",
		args = { "-m", "debugpy.adapter" },
	}

	dap.configurations.lua = {
		{
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
			host = function()
				local value = vim.fn.input("Host [127.0.0.1]: ")
				if value ~= "" then
					return value
				end
				return "127.0.0.1"
			end,
			port = function()
				local val = tonumber(vim.fn.input("Port: "))
				assert(val, "Please provide a port number")
				return val
			end,
		},
	}

	dap.adapters.nlua = function(callback, config)
		callback({ type = "server", host = config.host, port = config.port })
	end

	dap.adapters.go = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/Dev/repos/vscode-go/dist/debugAdapter.js" },
	}
	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}",
			dlvToolPath = vim.fn.exepath("dlv"),
		},
	}

	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = {
			os.getenv("HOME") .. "/Dev/repos/vscode-node-debug2/out/src/nodeDebug.js",
		},
	}
	dap.configurations.javascript = {
		{
			type = "node2",
			request = "launch",
			program = "${workspaceFolder}/${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}
	dap.configurations.typescript = dap.configurations.javascript

	dap.adapters.codelldb = function(on_adapter)
		local stdout = vim.loop.new_pipe(false)
		local stderr = vim.loop.new_pipe(false)

		local cmd = "/Users/miki/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/adapter/codelldb"

		local handle, pid_or_err
		local opts = {
			stdio = { nil, stdout, stderr },
			detached = true,
		}
		handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
			stdout:close()
			stderr:close()
			handle:close()
			if code ~= 0 then
				print("codelldb exited with code", code)
			end
		end)
		assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				local port = chunk:match("Listening on port (%d+)")
				if port then
					vim.schedule(function()
						on_adapter({
							type = "server",
							host = "127.0.0.1",
							port = port,
						})
					end)
				else
					vim.schedule(function()
						require("dap.repl").append(chunk)
					end)
				end
			end
		end)
		stderr:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end)
	end

	dap.configurations.rust = {
		{
			type = "codelldb",
			request = "launch",
			name = "Launch",
			program = function()
				local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
				local metadata = vim.fn.json_decode(metadata_json)
				local target_name = metadata.packages[1].targets[1].name
				local target_dir = metadata.target_directory
				return target_dir .. "/debug/" .. target_name
			end,
		},
	}

	dap.configurations.c = {
		{
			-- If you get an "Operation not permitted" error using this, try disabling YAMA:
			--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			name = "Attach to process",
			type = "codelldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
			request = "attach",
			pid = require("dap.utils").pick_process,
			args = {},
		},
	}

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
end

return M
