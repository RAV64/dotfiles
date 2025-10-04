local api, ts, diag = vim.api, vim.treesitter, vim.diagnostic

local ns = api.nvim_create_namespace("treesitter-diagnostics")
local root_group = api.nvim_create_augroup("treesitter-diagnostics", { clear = true })
local group = api.nvim_create_augroup("treesitter-diagnostics-buf", { clear = true })
local max_errors = 10

local error_query = (function()
	local ok, q = pcall(ts.query.parse, "query", "[(ERROR) (MISSING)] @n")
	return ok and q or nil
end)()

local function eligible(bufnr)
	local bo = vim.bo[bufnr]
	return bo.buftype == "" and bo.buflisted and bo.modifiable
end

local function lsp_attached(bufnr)
	return #vim.lsp.get_clients({ bufnr = bufnr }) > 0
end

local function range_key(n)
	local srow, scol, erow, ecol = n:range()
	return table.concat({ srow, scol, erow, ecol }, ":")
end

local function same_range(a, b)
	if not (a and b) then
		return false
	end
	local asr, asc, aer, aec = a:range()
	local bsr, bsc, ber, bec = b:range()
	return asr == bsr and asc == bsc and aer == ber and aec == bec
end

local function build_message(buf, node)
	local missing = node:missing()
	local msg

	if missing then
		msg = ("missing `%s`"):format(node:type())
	else
		msg = "syntax error"
		local nsl, nsc, nel, nec = node:range()
		local ok, text = pcall(api.nvim_buf_get_text, buf, nsl, nsc, nel, nec, {})
		local tok = (ok and text and text[1]) and text[1] or nil
		if tok and #tok > 0 then
			if #tok > 20 then
				tok = tok:sub(1, 17) .. "..."
			end
			msg = msg .. (": unexpected '%s'"):format(tok)
		end
	end

	local prev = node:prev_sibling()
	if prev and prev:type() ~= "ERROR" then
		local label = prev:named() and prev:type() or ("`" .. prev:type() .. "`")
		msg = msg .. " after " .. label
	end

	local parent = node:parent()
	if parent and parent:type() ~= "ERROR" then
		msg = msg .. " in " .. parent:type()
	end

	return msg
end

local function collect_tree_diags(tree, lang, buf)
	local root = tree:root()
	if not root or not root:has_error() or not error_query then
		return {}
	end

	local out, seen = {}, {}
	local start_row = select(1, root:start())
	local end_row = select(1, root:end_())

	for _, node in error_query:iter_captures(root, buf, start_row, end_row) do
		local parent = node:parent()
		local skip_same_range_child = parent and parent:type() == "ERROR" and same_range(node, parent)

		if not skip_same_range_child then
			local key = range_key(node)
			if not seen[key] then
				seen[key] = true
				local srow, scol, erow, ecol = node:range()
				out[#out + 1] = {
					lnum = srow,
					col = scol,
					end_lnum = erow,
					end_col = ecol,
					severity = diag.severity.ERROR,
					source = "treesitter-diagnostics",
					code = lang .. ".ts",
					message = build_message(buf, node),
				}

				if #out >= max_errors then
					return out
				end
			end
		end
	end

	return out
end

local function diagnose(buf)
	if not diag.is_enabled({ bufnr = buf }) then
		return
	end

	local parser = ts.get_parser(buf, nil, { error = false })
	if not parser then
		return
	end
	parser:parse()

	local all = {}
	parser:for_each_tree(function(tree, langtree)
		local diags = collect_tree_diags(tree, langtree:lang(), buf)
		if #diags > 0 then
			vim.list_extend(all, diags)
		end
	end)

	diag.set(ns, buf, all)
end

local function enable(buf)
	if not eligible(buf) then
		return
	end
	api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
		group = group,
		buffer = buf,
		desc = "treesitter diagnostics",
		callback = function()
			diagnose(buf)
		end,
	})
	diagnose(buf)
end

local function disable(buf)
	api.nvim_clear_autocmds({ group = group, buffer = buf })
	diag.reset(ns, buf)
end

api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = root_group,
	desc = "enable treesitter diagnostics (no LSP)",
	callback = function(ev)
		if lsp_attached(ev.buf) then
			disable(ev.buf)
		else
			enable(ev.buf)
		end
	end,
})

api.nvim_create_autocmd("LspAttach", {
	group = root_group,
	desc = "disable treesitter diagnostics when LSP attaches",
	callback = function(ev)
		disable(ev.buf)
	end,
})

api.nvim_create_autocmd("LspDetach", {
	group = root_group,
	desc = "enable treesitter diagnostics when last LSP detaches",
	callback = function(ev)
		if not lsp_attached(ev.buf) then
			enable(ev.buf)
		end
	end,
})
