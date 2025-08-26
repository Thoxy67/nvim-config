return {
  {
    "lewis6991/satellite.nvim",
    event = "BufEnter",
    opts = {},
    config = function(_, opts)
      require("satellite").setup(opts)
    end,
  },
}
