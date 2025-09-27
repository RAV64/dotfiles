local api, ts, diag = vim.api, vim.treesitter, vim.diagnostic
local root_group = api.nvim_create_augroup("editor.treesitter.core", { clear = true })
local group = api.nvim_create_augroup("editor.treesitter.buf", { clear = true })
local error_q = ts.query.parse("query", "[(ERROR)(MISSING)] @a")
local ns = api.nvim_create_namespace("treesitter.diagnostics")
local SEV = diag.severity.ERROR

local function same_range(a_sl, a_sc, a_el, a_ec, b_sl, b_sc, b_el, b_ec)
	return a_sl == b_sl and a_sc == b_sc and a_el == b_el and a_ec == b_ec
end

local function clamp_multiline(ln, col, eln, ecol)
	if eln > ln then
		return ln, col, ln + 1, 0
	end
	return ln, col, eln, ecol
end

local function should_skip(parent_type, nls, ncs, nle, nce, pls, pcs, ple, pce)
	if not parent_type or parent_type ~= "ERROR" then
		return false
	end
	return same_range(nls, ncs, nle, nce, pls, pcs, ple, pce)
end

local function build_message(node, parent)
	local msg = node:missing() and string.format("missing `%s`", node:type()) or "error"

	local prev = node:prev_sibling()
	local prev_type = prev and prev:type()
	local parent_type = parent and parent:type()

	if prev and prev_type ~= "ERROR" then
		local after = prev:named() and prev_type or string.format("`%s`", prev_type)
		msg = msg .. " after " .. after
	end

	if parent and parent_type ~= "ERROR" and (not prev or prev_type ~= parent_type) then
		msg = msg .. " in " .. parent_type
	end

	return msg
end

local function collect_tree_diags(tree, lang, buf)
	local root = tree:root()
	if not root or not root:has_error() then
		return {}
	end
	local out = {}
	for _, node in error_q:iter_captures(root, buf) do
		local parent = node:parent()

		local nls, ncs, nle, nce = node:range()
		local ptype, pls, pcs, ple, pce
		if parent then
			ptype = parent:type()
			pls, pcs, ple, pce = parent:range()
		end

		if not should_skip(ptype, nls, ncs, nle, nce, pls, pcs, ple, pce) then
			local ln, col, eln, ecol = clamp_multiline(nls, ncs, nle, nce)
			out[#out + 1] = {
				lnum = ln,
				col = col,
				end_lnum = eln,
				end_col = ecol,
				severity = SEV,
				source = "treesitter-diagnostics",
				code = (lang .. "-treesitter"),
				message = build_message(node, parent),
			}
		end
	end
	return out
end

local function eligible(buf)
	if vim.bo[buf].buftype ~= "" then
		return false
	end
	if not vim.bo[buf].buflisted then
		return false
	end
	if not vim.bo[buf].modifiable then
		return false
	end
	return true
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

local function lsp_attached(buf)
	return #vim.lsp.get_clients({ bufnr = buf }) > 0
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
	desc = "conditionally enable treesitter diagnostics (no LSP)",
	callback = function(ev)
		if not lsp_attached(ev.buf) then
			enable(ev.buf)
		else
			disable(ev.buf)
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
	desc = "enable treesitter diagnostics when LSP detaches (and no others remain)",
	callback = function(ev)
		if not lsp_attached(ev.buf) then
			enable(ev.buf)
		end
	end,
})
