-- markview.lua - Enhanced markdown rendering for neovim
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
            hybrid_modes = { "n" }, -- Show preview in normal mode
            icon_provider = "devicons", -- Use devicons for file type icons
          },
        },
        config = function()
          dofile(vim.g.base46_cache .. "markview")
        end,
      },
    },
  },
}
