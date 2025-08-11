-- lsp-signature.lua - Function signature help (disabled)
return {
  {
    enabled = false, -- Disabled because it can conflict with other completion
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup()
    end,
  },
}
