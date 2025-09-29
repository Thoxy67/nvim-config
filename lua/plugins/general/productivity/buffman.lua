return {
  "Jaehaks/bufman.nvim",
  keys = {
    {
      "<leader>fB",
      function()
        require("bufman").toggle_manager()
      end,
      noremap = true,
      desc = "open buffer window",
    },
    {
      "<M-,>",
      function()
        require("bufman").bnext()
      end,
      noremap = true,
      desc = "go to next buffer",
    },
    {
      "<M-n>",
      function()
        require("bufman").bprev()
      end,
      noremap = true,
      desc = "go to previous buffer",
    },
  },
  opts = {},
}
