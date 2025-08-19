local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

lspconfig.svelte.setup {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "vue",
  },
  root_dir = util.root_pattern("vue.config.js", "vue.config.ts"),
  settings = {
    svelte = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = vim.fn.has "nvim-0.10" == 0 and { dynamicRegistration = true },
        },
      },
    },
  },
}

lspconfig.vtsls.setup {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "svelte",
  },
  root_dir = util.root_pattern("svelte.config.js", "svelte.config.mjs", "svelte.config.cjs"),
  settings = {
    vtsls = {},
  },
}

return {
  { import = "plugins.languages.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "svelte" } },
  },

  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "svelte-language-server",
      },
    },
  },
}
