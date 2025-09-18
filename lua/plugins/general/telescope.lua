return {
  {
    "telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find All Files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Old Files" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Current Buffer" },
      { "<leader>cm", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>pt", "<cmd>Telescope terms<cr>", desc = "Pick Hidden Term" },
      { "<leader>th", "<cmd>Telescope themes<cr>", desc = "NvChad Themes" },
      { "<leader>ma", "<cmd>Telescope marks<cr>", desc = "Telescope Bookmarks" },
    },
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
