return {
  {

    "nvim-treesitter",
    lazy = false,
    priority = 49,
    dependencies = {
      "saghen/blink.cmp",
      {
        "OXY2DEV/markview.nvim",
        opts = {
          preview = {
            hybrid_modes = { "n" },
            --headings = { shift_width = 0 },
            icon_provider = "devicons", -- "mini" or "devicons"
          },
        },
        config = function()
          dofile(vim.g.base46_cache .. "markview")
        end,
      },
    },
  },
}
