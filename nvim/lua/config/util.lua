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
	vim.notify("Execution duration: " .. execution_duration_ms .. " ms")
end

function M.find_file(config)
	-- Get the parent directory of the current file
	local path = vim.fn.expand("%:p:h:h")

	local function _find_file(current_path)
		local config_path = current_path .. "/" .. config
		if vim.fn.filereadable(config_path) == 1 then -- If config is found, open it
			vim.cmd("edit " .. config_path)
		else -- Move to the parent directory and search again
			local parent_path = vim.fn.fnamemodify(current_path, ":h")
			if parent_path == current_path then -- If reached the root directory and no config found
				vim.notify(config .. " not found in any parent directories", vim.log.levels.INFO)
			else
				return _find_file(parent_path)
			end
		end
	end

	-- Start the search from the current file's directory
	_find_file(path)
end

function M.get_top_level_keys(tbl)
	local keys = {}

	for key, _ in pairs(tbl) do
		table.insert(keys, key)
	end

	return keys
end

M.capabilities = function(opt)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	if opt then
		capabilities = vim.tbl_deep_extend("force", capabilities, opt)
	end

	return require("blink.cmp").get_lsp_capabilities(capabilities)
end

local mod_cache = {}

local function set_and_get(m)
	mod_cache[m] = require(m)
	return mod_cache[m]
end

function M.func(m, f, ...)
	return (mod_cache[m] or set_and_get(m))[f](...)
end

return M
