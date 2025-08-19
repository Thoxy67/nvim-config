return {
  {
    "https://git.thoxy.xyz/thoxy/synccode.nvim",
    event = "VeryLazy",
    opts = {
      -- Optional: Check dependencies on startup
      check_deps_on_startup = false,
      -- Optional: Show welcome message
      show_welcome = false,
    },
    config = function(_, opts)
      require("transfer").setup(opts)
    end,
  },
}
