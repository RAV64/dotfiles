return {
  "ggandor/leap.nvim",
  event = "BufReadPost",
  config = function()
    require("leap").set_default_keymaps()
  end,
}
