return {
  {
    "which-key.nvim",
    event = "VimEnter",
    priority = 1000,
    dependencies = {
      "nvim-mini/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {
        delay = 0,
        icons = {
          mappings = vim.g.have_nerd_font,
        },
      }
    end,
    keys = { "<leader>", "\\", "<c-w>", '"', "'", "`", "c", "v", "g" },
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },
}
