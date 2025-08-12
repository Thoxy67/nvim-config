-- notify.lua - Better notifications
return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      timeout = 5000, -- Notification timeout in milliseconds
      background_colour = "#000000",
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "notify")
      require("notify").setup(opts)
      vim.notify = require "notify" -- Replace default vim.notify
    end,
  },
}
