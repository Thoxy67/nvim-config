-- notify.lua - Better notifications
return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      timeout = 5000, -- Notification timeout in milliseconds
    },
    config = function()
      dofile(vim.g.base46_cache .. "notify")
      vim.notify = require "notify" -- Replace default vim.notify
    end,
  },
}
