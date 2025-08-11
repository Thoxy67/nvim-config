-- git-conflict.lua - Merge conflict resolution
return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {},
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git-conflict") -- Load theme
      require("git-conflict").setup(opts)
    end,
  },
}
