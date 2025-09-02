return {
  {
    "oribarilan/lensline.nvim",
    event = "LspAttach",
    config = function()
      require("lensline").setup()
      require("lensline").disable()
    end,
  },
}
