local M = {}

function M.update_lead()
	local lead_chr = string.gsub(vim.opt_local.listchars:get().leadmultispace, "%s+", "")
	local cache = {}

	local function update_cache(int)
		cache[int] = lead_chr .. string.rep(" ", int - 1)
		return cache[int]
	end

	return function()
		local lead = cache[vim.bo.shiftwidth] or update_cache(vim.bo.shiftwidth)
		vim.opt_local.listchars:append({ leadmultispace = lead })
	end
end

function M.timer(func, ...)
	local start_time = os.clock()
	func(...)
	local end_time = os.clock()
	local execution_duration_ms = (end_time - start_time) * 1000
	print("Execution duration: " .. execution_duration_ms .. " ms")
end

function M.find_file(config)
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

M.rust = {}

local get_lsp_client = function(name)
	local clients = vim.lsp.get_clients({ name = name })
	if not clients or #clients == 0 then
		error("No " .. name .. " clients attached")
	end
	return clients[1]
end

function M.rust.refresh_cargo_workspace()
	local client = get_lsp_client("rust_analyzer")

	client.request("rust-analyzer/reloadWorkspace", nil, function(err)
		if err then
			vim.notify(tostring(err), vim.log.levels.ERROR)
			return
		end
		vim.notify("Cargo workspace reloaded")
	end)
end

function M.rust.go_to_parent_module()
	local client = get_lsp_client("rust_analyzer")

	client.request("experimental/parentModule", vim.lsp.util.make_position_params(0, nil), function(_, result, _)
		if result == nil or vim.tbl_isempty(result) then
			vim.notify("Can't find parent module")
			return
		end

		local location = vim.islist(result) and result[1] or result

		local path = vim.uri_to_fname(location.targetUri)
		local fname = vim.fn.fnamemodify(path, ":t")
		if fname == "Cargo.toml" then
			vim.notify("Already at root module")
			return
		end

		vim.lsp.util.jump_to_location(location, client.offset_encoding)
	end)
end

return M
