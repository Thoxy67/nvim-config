-- log-highlight.lua - Syntax highlighting for log files
return {
  {
    "fei6409/log-highlight.nvim",
    event = "BufEnter",
    opts = {
      pattern = {
        ".*%.log%.%d+", -- Match log files with rotation numbers
      },
    },
    config = function(_, opts)
      require("log-highlight").setup(opts)
    end,
  },
}
