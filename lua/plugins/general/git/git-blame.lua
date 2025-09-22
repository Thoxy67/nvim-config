return {
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameToggle", "GitBlameCopyCommitURL", "GitBlameCopyFileURL", "GitBlameOpenCommitURL", "GitBlameOpenFileURL" },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
    },
    opts = {
      enabled = false,
    },
  },
}
