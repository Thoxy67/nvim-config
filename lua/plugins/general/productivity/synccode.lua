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
        sync = "<leader>Ss", -- Sync now (push)
        pull = "<leader>Sp", -- Pull from remote
        interactive = "<leader>Si", -- Interactive sync
        watch = "<leader>Sw", -- Toggle watch mode
        status = "<leader>Sl", -- Show status
        init = "<leader>Sc", -- Initialize config
      },
    },
    config = function(_, opts)
      require("transfer").setup(opts)
    end,
  },
}
