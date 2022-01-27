local status, actions = pcall(require, "telescope.actions")
if not status then
  print("ERROR: telescope.actions")
  return
end

require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true
    }
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    file_ignore_patterns = {
      "node_modules",
      "venv",
      "packer_compiled.lua",
      ".cache",
      ".gradle",
      "flutter",
      "pytorch",
      "*.gpg",
    },
    prompt_prefix = '🔭 ',
    prompt_position = 'top',
    selection_caret = " ",
    sorting_strategy = "ascending",
    color_devicons = true,
    dynamic_preview_title = true,
    background = true,
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    selection_strategy = "reset",
    results_width = 0.9,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    file_browser = {
      hidden = true,
    },
  },
  mappings = {
    i = {
      ["<Tab>"] = actions.move_selection_next,
      ["<S-Tab>"] = actions.move_selection_previous,
    },
    n = {
      ["<Tab>"] = actions.move_selection_next,
      ["<S-Tab>"] = actions.move_selection_previous,
    },
    c = {
      ["<Tab>"] = actions.move_selection_next,
      ["<S-Tab>"] = actions.move_selection_previous,
    },
  },
}
require('telescope').load_extension('fzy_native')
require("telescope").load_extension('file_browser')

local M = {}

function M.file_explorer()
  require('telescope.builtin').file_browser{
    prompt_title = '✨ File Explorer ✨',
    shorten_path = false,
    cwd = "~",
    width = .25,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_widht = .65,
    },
  }
end

return M