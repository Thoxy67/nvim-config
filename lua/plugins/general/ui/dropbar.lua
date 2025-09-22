-- dropbar.lua - Breadcrumb navigation
return {
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
}
