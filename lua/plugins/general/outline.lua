-- outline.lua - Code structure outline
return {
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    opts = {},
    config = function(_, opts)
      require("outline").setup(opts)
    end,
  },
}
