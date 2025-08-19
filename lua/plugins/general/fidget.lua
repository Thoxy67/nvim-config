return {
  {
    "j-hui/fidget.nvim",
    event = "BufRead",
    opts = {},
    config = function(_, opts)
      require("fidget").setup(opts)
    end,
  },
}
