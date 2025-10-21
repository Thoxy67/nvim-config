return {
  {
    "stevearc/overseer.nvim",
    version = "1.6.0",
    opts = {},
    config = function(_, opts)
      require("overseer").setup(opts)
    end,
  },
}
