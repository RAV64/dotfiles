return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "tpope/vim-sleuth", event = "VeryLazy" },

  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<S-q>", "<cmd>bdelete<cr>", desc = "Delete current buffer" },
    },
  },

  { "max397574/better-escape.nvim", event = "InsertEnter", config = true },
}
