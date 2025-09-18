local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.vue_ls = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_markers = { "vue.config.js", "vue.config.ts" },
  settings = {
    vue_ls = {
      init_options = {
        vue = {
          hybridMode = true,
        },
      },
    },
  },
}

vim.lsp.config.vtsls = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_markers = { "vue.config.js", "vue.config.ts" },
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
