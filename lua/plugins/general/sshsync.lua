return {
  {
    "https://git.thoxy.xyz/thoxy/sshsync.nvim",
    lazy = true,
    cmd = {
      "TransferInit",
      "TransferToggle",
      "TransferSync",
      "TransferStatus",
      "TransferCheckDeps",
    },
    config = function()
      require("transfer").setup {
        -- Optional: Check dependencies on startup
        check_deps_on_startup = false,
        -- Optional: Show welcome message
        show_welcome = false,
      }
    end,
  },
}
