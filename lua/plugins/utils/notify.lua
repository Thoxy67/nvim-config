return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      timeout = 5000,
    },
    config = function()
      -- dofile(vim.g.base46_cache .. "notify")
      vim.notify = require "notify"
    end,
  },
}
