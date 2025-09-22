return {
  {
    "saecki/live-rename.nvim",
    keys = {
      {
        "<leader>R",
        function()
          require("live-rename").rename { text = "", insert = true }
        end,
        mode = "v",
        desc = "LSP rename",
      },
      {
        "<leader>R",
        function()
          require("live-rename").rename { text = "", insert = true }
        end,
        mode = "n",
        desc = "LSP rename",
      },
    },
    opts = {},
    config = function(_, opts)
      require("live-rename").setup(opts)
    end,
  },
}
