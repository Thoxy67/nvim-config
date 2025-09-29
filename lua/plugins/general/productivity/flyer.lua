return {
  {
    "A7Lavinraj/fyler.nvim",
    cmd = { "Fyler" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { icon_provider = "nvim_web_devicons" },
    config = function(_, opts)
      require("fyler").setup(opts)
    end,
  },
}
