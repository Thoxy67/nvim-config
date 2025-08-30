return {
  {
    "cljoly/telescope-repo.nvim",
    enabled = false,
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
  {
    "nvim-telescope/telescope-media-files.nvim",
    opts = {},
    config = function()
      require("telescope").setup {
        extensions = {
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            -- find command (defaults to `fd`)
            find_cmd = "rg",
          },
        },
      }
      require("telescope").load_extension "media_files"
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    opts = {},
    config = function()
      require("telescope").load_extension "file_browser"
    end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
}
