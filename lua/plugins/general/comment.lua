return {
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    opts = {
      -- add any options here
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
}
