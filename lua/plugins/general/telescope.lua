return {
  {
    "cljoly/telescope-repo.nvim",
    opts = {},
    config = function()
      require("telescope").load_extension "repo"
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "LukasPietzschmann/telescope-tabs",
    opts = {},
    config = function(_, opts)
      require("telescope").load_extension "telescope-tabs"
      require("telescope-tabs").setup(opts)
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "ghassan0/telescope-glyph.nvim",
    opts = {},
    config = function()
      require("telescope").load_extension "glyph"
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}
