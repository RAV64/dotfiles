return {
	"akinsho/nvim-bufferline.lua",
	event = "VeryLazy",
	dependencies = { { "nvim-tree/nvim-web-devicons" }, { "catppuccin/nvim" } },

	init = function()
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				require("bufferline").go_to_buffer(i, true)
			end)
		end

		vim.keymap.set("n", "<leader>" .. 0, function()
			require("bufferline").go_to_buffer(-1, true)
		end)

		vim.keymap.set("n", "<Tab>", function()
			require("bufferline").cycle(1)
		end)
		vim.keymap.set("n", "<S-Tab>", function()
			require("bufferline").cycle(-1)
		end)
	end,

	config = function()
		require("bufferline").setup({
			options = {
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				diagnostics = "nvim_lsp",
				-- enforce_regular_tabs = false,
				indicator = { icon = " " },
				max_name_length = 50,
				max_prefix_length = 6,
				modified_icon = "●",
				persist_buffer_sort = true,
				show_buffer_close_icons = false,
				show_buffer_icons = true,
				show_close_icon = false,
				name_formatter = function(opts)
					return string.format(" %s ", opts.name)
				end,
				numbers = function(opts)
					return string.format(" %s ", opts.ordinal)
				end,
				diagnostics_indicator = function(_, _, diag)
					local ret = (diag.error and " " or "") .. (diag.warning and " " or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/" .. string.rep(" ", 30),
						text_align = "left",
					},
				},
			},
		})
	end,
}
