return {
  {
    "lewis6991/satellite.nvim",
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
      require("satellite").setup(opts)
    end,
  },
}
