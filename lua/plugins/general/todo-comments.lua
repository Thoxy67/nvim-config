return {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup {
        keywords = {
          GROUP = { icon = " ", color = "hint" }, -- Custom keyword
          HERE = { icon = " ", color = "here" }, -- Custom keyword
        },
        colors = {
          here = "#fdf5a4", -- Custom color for HERE keyword
        },
        highlight = {
          multiline = true, -- Highlight multiline TODO comments
        },
      }
    end,
  },
}
