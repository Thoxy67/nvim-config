-- matchup.lua - Enhanced % matching for brackets, keywords, etc.
return {
  {
    "andymass/vim-matchup",
    event = "LspAttach",
    config = function()
      -- Show matching pairs in popup when off-screen
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}
