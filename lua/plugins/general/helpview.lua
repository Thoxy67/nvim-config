-- helpview.lua - Better help file rendering
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vimdoc" } },
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    opts = {
      preview = {
        icon_provider = "internal",
      },
    },
    lazy = false,
  },
}
