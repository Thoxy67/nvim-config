-- startuptime.lua - Measure startup performance
return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10 -- Number of startup measurements to average
    end,
  },
}
