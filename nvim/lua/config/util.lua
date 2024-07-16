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

return M
