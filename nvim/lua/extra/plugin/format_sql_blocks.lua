local home_dir = os.getenv("HOME")

local run_formatter = function(text)
	local split = vim.split(text, "\n")
	local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")
	print(home_dir)

	local j = require("plenary.job"):new({
		command = "bun",
		args = { "run", "sql-formatter", "-c", home_dir .. "/dotfiles/tool-configs/sql-formatter.json" },
		writer = { result },
	})
	return j:sync()
end

local embedded_sql = vim.treesitter.query.parse(
	"rust",
	[[
((string_literal) @sql
((#match? @sql "^\"(\n)?(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 1 0 -1)))

((raw_string_literal) @sql
((#match? @sql "^r\"(\n)?(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 2 0 -1)))

((raw_string_literal) @sql
((#match? @sql "^r#\"(\n)?(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 3 0 -2)))
]]
)

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "rust", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local format_sql = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local root = get_root(bufnr)

	local changes = {}
	for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_sql.captures[id]
		if name == "sql" then
			-- { start row, start col, end row, end col }
			local range = { node:range() }

			-- Run the formatter, based on the node text
			local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

			-- Add some indentation (can be anything you like!)
			for idx, line in ipairs(formatted) do
				formatted[idx] = line
			end

			-- Keep track of changes
			--    But insert them in reverse order of the file,
			--    so that when we make modifications, we don't have
			--    any out of date line numbers
			table.insert(changes, 1, {
				start = range[1] + 1,
				final = range[3],
				formatted = formatted,
			})
		end
	end

	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
	end
end

vim.api.nvim_create_user_command("SqlMagic", function()
	format_sql()
end, {})
