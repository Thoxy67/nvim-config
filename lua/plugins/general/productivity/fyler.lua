return {
  {
    "A7Lavinraj/fyler.nvim",
    cmd = { "Fyler" },
    keys = {
      {
        "<leader>f1",
        function()
          require("fyler").open()
        end,
        desc = "Open Fyler file manager",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { integrations = {
      icon = "nvim_web_devicons",
    } },
    config = function(_, opts)
      require("fyler").setup(opts)
    end,
  },
}
