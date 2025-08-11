return {
  {
    "fei6409/log-highlight.nvim",
    opts = {
      pattern = {
        ".*%.log%.%d+",
      },
    },
    config = function(_, opts)
      require("log-highlight").setup(opts)
    end,
  },
}
