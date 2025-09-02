-- outline.lua - Code structure outline
return {
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    opts = {},
    keys = {
      {
        "<leader>oo",
        "<cmd>Outline<CR>",
        mode = { "n" },
        desc = "Toggle code outline",
      },
    },
    config = function(_, opts)
      require("outline").setup(opts)
    end,
  },
}
