local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

lspconfig.volar.setup {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_dir = util.root_pattern("vue.config.js", "vue.config.ts"),
  settings = {
    volar = {
      init_options = {
        vue = {
          hybridMode = true,
        },
      },
    },
  },
}

lspconfig.vtsls.setup {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_dir = util.root_pattern("vue.config.js", "vue.config.ts"),
  settings = {
    vtsls = {},
  },
}

return {
  { import = "plugins.languages.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue", "css" } },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "vue-language-server",
      },
    },
  },
}
