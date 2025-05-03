local set = vim.keymap.set
local rust_analyzer = "rust-analyzer"

-- your go_to_parent_module from before
local go_to_parent_module = function()
	local bufnr = 0
	local clients = vim.lsp.get_clients({ name = rust_analyzer, bufnr = bufnr })
	if #clients == 0 then
		vim.notify("Rust Analyzer not attached", vim.log.levels.WARN)
		return
	end
	local client = clients[1]
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-16")

	---@diagnostic disable-next-line: param-type-mismatch
	vim.lsp.buf_request(bufnr, "experimental/parentModule", params, function(err, result)
		if err then
			vim.notify("Error: " .. (err.message or err), vim.log.levels.ERROR)
			return
		end
		if not result or vim.tbl_isempty(result) then
			vim.notify("Can't find parent module")
			return
		end

		local loc = vim.islist(result) and result[1] or result
		local uri = loc.targetUri or loc.uri
		local path = vim.uri_to_fname(uri)
		local fname = vim.fn.fnamemodify(path, ":t")
		if fname == "Cargo.toml" then
			vim.notify("Already at root module")
			return
		end

		vim.lsp.util.show_document(
			{ uri = uri, range = loc.targetRange or loc.range },
			client.offset_encoding or "utf-16",
			{ reuse_win = true, focus = true }
		)
	end)
end
set("n", "gp", go_to_parent_module, { buffer = true })

local function refresh_cargo_workspace()
	local clients = vim.lsp.get_clients({ name = rust_analyzer })
	if #clients == 0 then
		vim.notify("Rust Analyzer not attached", vim.log.levels.WARN)
		return
	end
	local client = clients[1]

	---@diagnostic disable-next-line: param-type-mismatch
	client:request("rust-analyzer/reloadWorkspace", nil, function(err)
		if err then
			vim.notify(tostring(err), vim.log.levels.ERROR)
			return
		end
		vim.notify("Cargo workspace reloaded")
	end)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("user-reload-rust-analyzer", { clear = true }),
	pattern = { "Cargo.toml" },
	callback = refresh_cargo_workspace,
})
