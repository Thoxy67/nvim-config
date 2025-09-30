local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.erlangls = {
  on_attach = on_attach,
  filetypes = { "erlang" },
  root_markers = { "rebar.config", "erlang.mk" },
}

vim.lsp.enable { "erlangls" }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        erlangls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "erlang" } },
  },
}
