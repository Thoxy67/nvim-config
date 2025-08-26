return {
  {
    "hinell/duplicate.nvim",
    keys = {
      { "<C-S-A-Up>", "<CMD>LineDuplicate -1<CR>", mode = "n", desc = "Duplicate Line Up" },
      { "<C-S-A-Down>", "<CMD>LineDuplicate +1<CR>", mode = "n", desc = "Duplicate Line Down" },
      { "<C-S-A-Up>", "<CMD>LineDuplicate -1<CR>", mode = "v", desc = "Duplicate Visual Selection Up" },
      { "<C-S-A-Down>", "<CMD>LineDuplicate +1<CR>", mode = "v", desc = "Duplicate Visual Selection Down" },
    },
  },
}
