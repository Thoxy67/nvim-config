-- rainbowdelimiters.lua - Rainbow colored brackets/delimiters
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")

      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"], -- Global strategy for most files
          vim = rainbow_delimiters.strategy["local"],   -- Local strategy for vim files
        },
        query = {
          [""] = "rainbow-delimiters", -- Default query
          lua = "rainbow-blocks",      -- Special query for Lua blocks
        },
        highlight = {
          "RainbowDelimiterYellow",
          "RainbowDelimiterRed",
          "RainbowDelimiterOrange",
          "RainbowDelimiterBlue",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
}
