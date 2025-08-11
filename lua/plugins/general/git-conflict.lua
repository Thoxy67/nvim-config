return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {},
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git-conflict")
      require("git-conflict").setup(opts)
    end,
  },
}
