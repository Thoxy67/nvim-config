-- ============================================================================
-- Shell script LANGUAGE SUPPORT
-- lua/plugins/languages/shell.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.bashls = {
  on_attach = on_attach,
  filetypes = { "zsh", "sh" },
  settings = {
    bashls = {},
  },
}

vim.lsp.config.fish_lsp = {
  on_attach = on_attach,
  filetypes = { "fish" },
  settings = {
    fish_lsp = {},
  },
}

vim.lsp.config.nushell = {
  on_attach = on_attach,
  filetypes = { "nu" },
  settings = {
    nushell = {},
  },
}

vim.lsp.enable {
  "bashls",
  -- "fish_lsp",
  "nushell",
}

return {
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        -- "fish-lsp",
        "shfmt",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "fish", "bash", "nu" } },
  },
  {
    "isak102/ghostty.nvim",
    event = "BufWrite",
    config = function()
      require("ghostty").setup()
    end,
  },
}
