-- fugitive.lua - Comprehensive Git wrapper
return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-rhubarb", -- GitHub integration
      "tpope/vim-obsession", -- Session management
      "tpope/vim-unimpaired", -- Bracket mappings
    },
  },
}
