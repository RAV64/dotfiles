local islist = vim.islist
local tbl_flatten = function(x)
	return vim.iter(x):flatten(math.huge):totable()
end

local Surround = {}
local cache = {}

local ns = vim.api.nvim_create_namespace("SurroundInput")
local map = vim.keymap.set

local plugin = "(surround)"

local plugin_error = function(msg)
	error(plugin .. " " .. msg, 0)
end

local new_span = function(from, to)
	return { from = from, to = to == nil and from or (to + 1) }
end

local set_cursor = function(line, col)
	vim.api.nvim_win_set_cursor(0, { line, col - 1 })
end

local region_is_empty = function(region)
	return region.to == nil
end

local unecho = function()
	if cache.msg_shown then
		vim.cmd([[echo '' | redraw]])
	end
end

local get_line_cols = function(line_num)
	return vim.fn.getline(line_num):len()
end

local is_region = function(x)
	if type(x) ~= "table" then
		return false
	end
	local from_is_valid = type(x.from) == "table" and type(x.from.line) == "number" and type(x.from.col) == "number"
	local to_is_valid = true
	if x.to ~= nil then
		to_is_valid = type(x.to) == "table" and type(x.to.line) == "number" and type(x.to.col) == "number"
	end
	return from_is_valid and to_is_valid
end

local is_region_pair = function(x)
	if type(x) ~= "table" then
		return false
	end
	return is_region(x.left) and is_region(x.right)
end

local is_region_pair_array = function(x)
	if not islist(x) then
		return false
	end
	for _, v in ipairs(x) do
		if not is_region_pair(v) then
			return false
		end
	end
	return true
end

local string_find = function(s, pattern, init)
	init = init or 1

	if pattern:sub(1, 1) == "^" then
		if init > 1 then
			return nil
		end
		return string.find(s, pattern)
	end

	local check_left, _, prev = string.find(pattern, "(.)%.%-")
	local is_pattern_special = check_left ~= nil and prev ~= "%"
	if not is_pattern_special then
		return string.find(s, pattern, init)
	end

	local from, to = string.find(s, pattern, init)
	if from == nil then
		return
	end

	local cur_from, cur_to = from, to
	while cur_to == to do
		from, to = cur_from, cur_to
		---@diagnostic disable-next-line: cast-local-type
		cur_from, cur_to = string.find(s, pattern, cur_from + 1)
	end

	return from, to
end

local is_span_covering = function(span, span_to_cover)
	if span == nil or span_to_cover == nil then
		return false
	end
	if span.from == span.to then
		return (span.from == span_to_cover.from) and (span_to_cover.to == span.to)
	end
	if span_to_cover.from == span_to_cover.to then
		return (span.from <= span_to_cover.from) and (span_to_cover.to < span.to)
	end

	return (span.from <= span_to_cover.from) and (span_to_cover.to <= span.to)
end

local iterate_matched_spans = function(line, nested_pattern, f)
	local max_level = #nested_pattern
	local visited = {}

	local process
	process = function(level, level_line, level_offset)
		local pattern = nested_pattern[level]
		local next_span = function(s, init)
			return string_find(s, pattern, init)
		end
		if vim.is_callable(pattern) then
			next_span = pattern
		end

		local is_same_balanced = type(pattern) == "string" and pattern:match("^%%b(.)%1$") ~= nil
		local init = 1
		while init <= level_line:len() do
			local from, to = next_span(level_line, init)
			if from == nil then
				break
			end

			if level == max_level then
				local found_match = new_span(from + level_offset, to + level_offset)
				local found_match_id = string.format("%s_%s", found_match.from, found_match.to)
				if not visited[found_match_id] then
					f(found_match)
					visited[found_match_id] = true
				end
			else
				local next_level_line = level_line:sub(from, to)
				local next_level_offset = level_offset + from - 1
				process(level + 1, next_level_line, next_level_offset)
			end

			init = (is_same_balanced and to or from) + 1
		end
	end

	process(1, line, 0)
end

local is_span_equal = function(span_1, span_2)
	if span_1 == nil or span_2 == nil then
		return false
	end
	return (span_1.from == span_2.from) and (span_1.to == span_2.to)
end

local is_better_covering_span = function(candidate, current, reference)
	local candidate_is_covering = is_span_covering(candidate, reference)
	local current_is_covering = is_span_covering(current, reference)

	if candidate_is_covering and current_is_covering then
		return (candidate.to - candidate.from) < (current.to - current.from)
	end
	if candidate_is_covering and not current_is_covering then
		return true
	end
	if not candidate_is_covering and current_is_covering then
		return false
	end

	return nil
end

local cover = function(candidate, current, reference)
	local res = is_better_covering_span(candidate, current, reference)
	if res ~= nil then
		return res
	end
	return false
end

local is_better_span = function(candidate, current, reference)
	if is_span_covering(reference, candidate) or is_span_equal(candidate, reference) then
		return false
	end

	return cover(candidate, current, reference)
end

local is_composed_pattern = function(x)
	if not (islist(x) and #x > 0) then
		return false
	end
	for _, val in ipairs(x) do
		local val_type = type(val)
		if not (val_type == "table" or val_type == "string" or vim.is_callable(val)) then
			return false
		end
	end
	return true
end

local get_selection_type = function(mode)
	if mode == "char" then
		return "charwise"
	end
	if mode == "line" then
		return "linewise"
	end
	plugin_error("bad mode: " .. mode)
end

local echo = function(msg, is_important)
	msg = type(msg) == "string" and { { msg } } or msg
	table.insert(msg, 1, { plugin .. " ", "WarningMsg" })

	local max_width = vim.o.columns * math.max(vim.o.cmdheight - 1, 0) + vim.v.echospace
	local chunks, tot_width = {}, 0
	for _, ch in ipairs(msg) do
		local new_ch = { vim.fn.strcharpart(ch[1], 0, max_width - tot_width), ch[2] }
		table.insert(chunks, new_ch)
		tot_width = tot_width + vim.fn.strdisplaywidth(new_ch[1])
		if tot_width >= max_width then
			break
		end
	end

	vim.cmd([[echo '' | redraw]])
	vim.api.nvim_echo(chunks, is_important, {})
end

local cartesian_product = function(arr)
	if not (type(arr) == "table" and #arr > 0) then
		return {}
	end
	arr = vim.tbl_map(function(x)
		return islist(x) and x or { x }
	end, arr)

	local res, cur_item = {}, {}
	local process
	process = function(level)
		for i = 1, #arr[level] do
			table.insert(cur_item, arr[level][i])
			if level == #arr then
				table.insert(res, tbl_flatten(cur_item))
			else
				process(level + 1)
			end
			table.remove(cur_item, #cur_item)
		end
	end

	process(1)
	return res
end

local wrap_callable_table = function(x)
	if vim.is_callable(x) and type(x) == "table" then
		return function(...)
			return x(...)
		end
	end
	return x
end

local make_operator = function(task, ask_for_textobject)
	return function()
		cache = { count = vim.v.count1 }
		vim.o.operatorfunc = "v:lua.Surround." .. task
		return '<Cmd>echon ""<CR>g@' .. (ask_for_textobject and "" or " ")
	end
end

local user_surround_id = function(sur_type)
	local needs_help_msg = true
	vim.defer_fn(function()
		if not needs_help_msg then
			return
		end

		local msg = string.format("Enter %s surrounding identifier (single character) ", sur_type)
		echo(msg)
		cache.msg_shown = true
	end, 1000)
	local ok, char = pcall(vim.fn.getcharstr)
	needs_help_msg = false
	unecho()

	if not ok or char == "\27" then
		return nil
	end
	return char
end

local user_input = function(prompt, text)
	local on_key = vim.on_key or vim.register_keystroke_callback
	local was_cancelled = false
	on_key(function(key)
		if key == vim.api.nvim_replace_termcodes("<Esc>", true, true, true) then
			was_cancelled = true
		end
	end, ns)

	local opts = { prompt = plugin .. " " .. prompt .. ": ", default = text or "" }
	vim.cmd("echohl Question")
	local ok, res = pcall(vim.fn.input, opts)
	vim.cmd([[echohl None | echo '' | redraw]])

	on_key(nil, ns)

	if not ok or was_cancelled then
		return
	end
	return res
end

local builtin_surroundings = {
	["("] = { input = { "%b()", "^.%s*().-()%s*.$" }, output = { left = "( ", right = " )" } },
	[")"] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
	["["] = { input = { "%b[]", "^.%s*().-()%s*.$" }, output = { left = "[ ", right = " ]" } },
	["]"] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
	["{"] = { input = { "%b{}", "^.%s*().-()%s*.$" }, output = { left = "{ ", right = " }" } },
	["}"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
	["<"] = { input = { "%b<>", "^.%s*().-()%s*.$" }, output = { left = "< ", right = " >" } },
	[">"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
	["b"] = { input = { { "%b()", "%b[]", "%b{}" }, "^.().*().$" }, output = { left = "(", right = ")" } },
	["q"] = { input = { { "'.-'", '".-"', "`.-`" }, "^.().*().$" }, output = { left = '"', right = '"' } },
	["f"] = {
		input = { "%f[%w_%.][%w_%.]+%b()", "^.-%(().*()%)$" },
		output = function()
			local fun_name = user_input("Function name")
			if fun_name == nil then
				return nil
			end
			return { left = ("%s("):format(fun_name), right = ")" }
		end,
	},
	["t"] = {
		input = { "<(%w-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
		output = function()
			local tag_full = user_input("Tag")
			if tag_full == nil then
				return nil
			end
			local tag_name = tag_full:match("^%S*")
			return { left = "<" .. tag_full .. ">", right = "</" .. tag_name .. ">" }
		end,
	},
}

local get_default_surrounding_info = function(char)
	local char_esc = vim.pesc(char)
	return { input = { char_esc .. "().-()" .. char_esc }, output = { left = char, right = char } }
end

local is_surrounding_info = function(x, sur_type)
	if sur_type == "input" then
		return is_composed_pattern(x) or is_region_pair(x) or is_region_pair_array(x)
	elseif sur_type == "output" then
		return (type(x) == "table" and type(x.left) == "string" and type(x.right) == "string")
	end
end

local make_surrounding_table = function()
	local surroundings = vim.deepcopy(builtin_surroundings)

	return setmetatable(surroundings, {
		__index = function(_, key)
			return get_default_surrounding_info(key)
		end,
	})
end

local get_surround_spec = function(sur_type)
	local res = cache[sur_type]
	if res ~= nil then
		return res
	end

	local char = user_surround_id(sur_type)
	if char == nil then
		return nil
	end

	res = make_surrounding_table()[char][sur_type]

	if vim.is_callable(res) then
		res = res()
	end

	if not is_surrounding_info(res, sur_type) then
		return nil
	end

	if is_composed_pattern(res) then
		res = vim.tbl_map(wrap_callable_table, res)
	end

	res = setmetatable(res, { __index = { id = char } })

	cache[sur_type] = res

	return res
end

local get_marks_pos = function(mode)
	local mark1, mark2 = "[", "]"

	local pos1 = vim.api.nvim_buf_get_mark(0, mark1)
	local pos2 = vim.api.nvim_buf_get_mark(0, mark2)

	local selection_type = get_selection_type(mode)

	if selection_type == "linewise" then
		local _, line1_indent = vim.fn.getline(pos1[1]):find("^%s*")
		pos1[2] = line1_indent

		pos2[2] = vim.fn.getline(pos2[1]):find("%s*$") - 2
	end

	pos1[2], pos2[2] = pos1[2] + 1, pos2[2] + 1

	local line2 = vim.fn.getline(pos2[1])
	local utf_index = vim.str_utfindex(line2, math.min(#line2, pos2[2]))
	pos2[2] = vim.str_byteindex(line2, utf_index)

	return {
		first = { line = pos1[1], col = pos1[2] },
		second = { line = pos2[1], col = pos2[2] },
		selection_type = selection_type,
	}
end

local region_replace = function(region, text)
	local start_row, start_col = region.from.line - 1, region.from.col - 1

	local end_row, end_col
	if region_is_empty(region) then
		end_row, end_col = start_row, start_col
	else
		end_row, end_col = region.to.line - 1, region.to.col

		if end_row < vim.api.nvim_buf_line_count(0) and get_line_cols(end_row + 1) < end_col then
			end_row, end_col = end_row + 1, 0
		end
	end

	if type(text) == "string" then
		text = { text }
	end

	if #text > 0 then
		text = vim.split(table.concat(text, "\n"), "\n")
	end

	pcall(vim.api.nvim_buf_set_text, 0, start_row, start_col, end_row, end_col, text)
end

local extract_surr_spans = function(s, extract_pattern)
	local positions = { s:match(extract_pattern) }

	local is_all_numbers = true
	for _, pos in ipairs(positions) do
		if type(pos) ~= "number" then
			is_all_numbers = false
		end
	end

	local is_valid_positions = is_all_numbers and (#positions == 2 or #positions == 4)
	if not is_valid_positions then
		local msg = "Could not extract proper positions (two or four empty captures) from "
			.. string.format([[string '%s' with extraction pattern '%s'.]], s, extract_pattern)
		plugin_error(msg)
	end

	if #positions == 2 then
		return { left = new_span(1, positions[1] - 1), right = new_span(positions[2], s:len()) }
	end
	return { left = new_span(positions[1], positions[2] - 1), right = new_span(positions[3], positions[4] - 1) }
end

local get_neighborhood = function(reference_region, n_neighbors)
	local from_line, to_line = reference_region.from.line, (reference_region.to or reference_region.from).line
	local line_start = math.max(1, from_line - n_neighbors)
	local line_end = math.min(vim.api.nvim_buf_line_count(0), to_line + n_neighbors)
	local neigh2d = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
	for k, v in pairs(neigh2d) do
		neigh2d[k] = v .. "\n"
	end

	local neigh1d = table.concat(neigh2d, "")

	local pos_to_offset = function(pos)
		if pos == nil then
			return nil
		end
		local line_num = line_start
		local offset = 0
		while line_num < pos.line do
			offset = offset + neigh2d[line_num - line_start + 1]:len()
			line_num = line_num + 1
		end

		return offset + pos.col
	end

	local offset_to_pos = function(offset)
		if offset == nil then
			return nil
		end
		local line_num = 1
		local line_offset = 0
		while line_num <= #neigh2d and line_offset + neigh2d[line_num]:len() < offset do
			line_offset = line_offset + neigh2d[line_num]:len()
			line_num = line_num + 1
		end

		return { line = line_start + line_num - 1, col = offset - line_offset }
	end

	local region_to_span = function(region)
		if region == nil then
			return nil
		end
		local is_empty = region.to == nil
		local to = region.to or region.from
		return { from = pos_to_offset(region.from), to = pos_to_offset(to) + (is_empty and 0 or 1) }
	end

	local span_to_region = function(span)
		if span == nil then
			return nil
		end
		local res = { from = offset_to_pos(span.from) }

		if span.from < span.to then
			res.to = offset_to_pos(span.to - 1)
		end
		return res
	end

	local is_region_inside = function(region)
		local res = line_start <= region.from.line
		if region.to ~= nil then
			res = res and (region.to.line <= line_end)
		end
		return res
	end

	return {
		n_neighbors = n_neighbors,
		region = reference_region,
		["1d"] = neigh1d,
		["2d"] = neigh2d,
		pos_to_offset = pos_to_offset,
		offset_to_pos = offset_to_pos,
		region_to_span = region_to_span,
		span_to_region = span_to_region,
		is_region_inside = is_region_inside,
	}
end

local find_best_match = function(neighborhood, surr_spec, reference_span)
	local best_span, best_nested_pattern, current_nested_pattern
	local f = function(span)
		if is_better_span(span, best_span, reference_span) then
			best_span = span
			best_nested_pattern = current_nested_pattern
		end
	end

	if is_region_pair_array(surr_spec) then
		for _, region_pair in ipairs(surr_spec) do
			local outer_region = { from = region_pair.left.from, to = region_pair.right.to or region_pair.right.from }

			if neighborhood.is_region_inside(outer_region) then
				current_nested_pattern = {
					{
						left = neighborhood.region_to_span(region_pair.left),
						right = neighborhood.region_to_span(region_pair.right),
					},
				}

				f(neighborhood.region_to_span(outer_region))
			end
		end
	else
		for _, nested_pattern in ipairs(cartesian_product(surr_spec)) do
			current_nested_pattern = nested_pattern
			iterate_matched_spans(neighborhood["1d"], nested_pattern, f)
		end
	end

	local extract_pattern
	if best_nested_pattern ~= nil then
		extract_pattern = best_nested_pattern[#best_nested_pattern]
	end
	return { span = best_span, extract_pattern = extract_pattern }
end

local find_surrounding_region_pair = function(surr_spec, opts)
	local reference_region, n_times, n_lines = opts.reference_region, opts.n_times, opts.n_lines

	if n_times == 0 then
		return
	end

	local neigh = get_neighborhood(reference_region, 0)
	local reference_span = neigh.region_to_span(reference_region)

	local find_next = function(cur_reference_span)
		local res = find_best_match(neigh, surr_spec, cur_reference_span)

		if res.span == nil then
			if n_lines == 0 or neigh.n_neighbors > 0 then
				return {}
			end

			local cur_reference_region = neigh.span_to_region(cur_reference_span)
			neigh = get_neighborhood(reference_region, n_lines)
			reference_span = neigh.region_to_span(reference_region)
			cur_reference_span = neigh.region_to_span(cur_reference_region)

			res = find_best_match(neigh, surr_spec, cur_reference_span)
		end

		return res
	end

	local find_res = { span = reference_span }
	for _ = 1, n_times do
		find_res = find_next(find_res.span)
		if find_res.span == nil then
			return
		end
	end

	local extract = function(span, extract_pattern)
		if type(extract_pattern) == "table" then
			return extract_pattern
		end

		local s = neigh["1d"]:sub(span.from, span.to - 1)
		local local_surr_spans = extract_surr_spans(s, extract_pattern)

		local off = span.from - 1
		local left, right = local_surr_spans.left, local_surr_spans.right
		return {
			left = { from = left.from + off, to = left.to + off },
			right = { from = right.from + off, to = right.to + off },
		}
	end

	local final_spans = extract(find_res.span, find_res.extract_pattern)
	local outer_span = { from = final_spans.left.from, to = final_spans.right.to }

	if is_span_covering(reference_span, outer_span) then
		find_res = find_next(find_res.span)
		if find_res.span == nil then
			return
		end
		final_spans = extract(find_res.span, find_res.extract_pattern)
		outer_span = { from = final_spans.left.from, to = final_spans.right.to }
		if is_span_covering(reference_span, outer_span) then
			return
		end
	end

	return { left = neigh.span_to_region(final_spans.left), right = neigh.span_to_region(final_spans.right) }
end

local get_default_opts = function()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	return {
		n_lines = Surround.config.n_lines,
		n_times = cache.count or vim.v.count1,
		reference_region = { from = { line = cur_pos[1], col = cur_pos[2] + 1 } },
	}
end

local find_surrounding = function(surr_spec, opts)
	if surr_spec == nil then
		return
	end
	if is_region_pair(surr_spec) then
		return surr_spec
	end

	opts = vim.tbl_deep_extend("force", get_default_opts(), opts or {})

	local region_pair = find_surrounding_region_pair(surr_spec, opts)
	if region_pair == nil then
		local msg = ([[No surrounding %s found within %d line%s.]]):format(
			vim.inspect((opts.n_times > 1 and opts.n_times or "") .. surr_spec.id),
			opts.n_lines,
			opts.n_lines > 1 and "s" or ""
		)
		echo(msg, true)
	end

	return region_pair
end

local apply_config = function(config)
	local expr_map = function(lhs, rhs, desc)
		map("n", lhs, rhs, { expr = true, desc = desc })
	end

	local m = config.mappings

	expr_map(m.add, make_operator("add", true), "Add surrounding")
	expr_map(m.delete, make_operator("delete"), "Delete surrounding")
	expr_map(m.replace, make_operator("replace"), "Replace surrounding")
end

Surround.add = function(mode)
	local marks = get_marks_pos(mode)

	local surr_info = get_surround_spec("output")
	if surr_info == nil then
		return "<Esc>"
	end

	if not surr_info.did_count then
		local count = cache.count or vim.v.count1
		surr_info.left, surr_info.right = surr_info.left:rep(count), surr_info.right:rep(count)
		surr_info.did_count = true
	end

	region_replace({ from = { line = marks.second.line, col = marks.second.col + 1 } }, surr_info.right)
	region_replace({ from = marks.first }, surr_info.left)

	set_cursor(marks.first.line, marks.first.col + surr_info.left:len())
end

Surround.delete = function()
	local surr = find_surrounding(get_surround_spec("input"))
	if surr == nil then
		return "<Esc>"
	end

	region_replace(surr.right, {})
	region_replace(surr.left, {})

	local from = surr.left.from
	---@diagnostic disable-next-line: need-check-nil
	set_cursor(from.line, from.col)
end

Surround.replace = function()
	local surr = find_surrounding(get_surround_spec("input"))
	if surr == nil then
		return "<Esc>"
	end

	local new_surr_info = get_surround_spec("output")
	if new_surr_info == nil then
		return "<Esc>"
	end

	region_replace(surr.right, new_surr_info.right)
	region_replace(surr.left, new_surr_info.left)

	local from = surr.left.from
	---@diagnostic disable-next-line: need-check-nil
	set_cursor(from.line, from.col + new_surr_info.left:len())
end

Surround.setup = function(config)
	_G.Surround = Surround
	Surround.config = config
	apply_config(config)
end

local config = {
	mappings = {
		add = "ms",
		delete = "md",
		replace = "mr",
	},
	n_lines = 20,
}

Surround.setup(config)
