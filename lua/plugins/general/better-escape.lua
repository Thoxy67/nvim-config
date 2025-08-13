-- better-escape - Better escape sequences (jk to escape)
return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },
}
