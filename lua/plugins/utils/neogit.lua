return {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function(_, opts)
      -- dofile(vim.g.base46_cache .. "neogit")
      require("neogit").setup(opts)
    end,
  },
}
