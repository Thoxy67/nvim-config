return {
  "chrisgrieser/nvim-lsp-endhints",
  event = "LspAttach",
  opts = {},
  init = function()
    vim.lsp.inlay_hint.enable()

    vim.keymap.set("n", "<leader>Ht", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle Inlay Hints" })
    vim.keymap.set("n", "<leader>He", function()
      require("lsp-endhints").toggle()
    end, { desc = "Toggle EndHints" })
  end,
}
