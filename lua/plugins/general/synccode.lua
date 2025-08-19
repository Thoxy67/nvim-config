return {
  {
    "https://git.thoxy.xyz/thoxy/synccode.nvim",
    event = "VeryLazy",
    opts = {
      -- Optional: Check dependencies on startup
      check_deps_on_startup = false,
      -- Optional: Show welcome message
      show_welcome = false,
      keymaps = {
        toggle = "<leader>St", -- Toggle auto-sync
        sync_now = "<leader>Ss", -- Sync now (push)
        pull_now = "<leader>Sp", -- Pull from remote
        watch_toggle = "<leader>Sw", -- Toggle watch mode
        init_config = "<leader>Sc", -- Initialize config
        check_deps = "<leader>Sd", -- Check dependencies
      },
    },
    config = function(_, opts)
      require("transfer").setup(opts)
    end,
  },
}
