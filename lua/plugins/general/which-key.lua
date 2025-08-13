return {
  {
    "folke/which-key.nvim",
    lazy = false,
    priority = 1000,
    keys = { "<leader>", "\\", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
}
