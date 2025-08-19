return {
  {
    "AndrewRadev/splitjoin.vim",
    event = "BufEnter",
    opts = {}, -- needed even when using default config
    keys = { "gS", "gJ" },
    config = function()
      vim.g.splitjoin_split_mapping = ""
      vim.g.splitjoin_join_mapping = ""
    end,
  },
}
