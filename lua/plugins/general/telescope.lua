return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "cljoly/telescope-repo.nvim",
      "LukasPietzschmann/telescope-tabs",
      "ghassan0/telescope-glyph.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
    },
    opts = {},
    config = function(_, opts)
      -- require("telescope").load_extension "repo"
      require("telescope-tabs").setup(opts)
      require("telescope").load_extension "telescope-tabs"
      require("telescope").load_extension "glyph"

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

      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "frecency"
    end,
  },
}
