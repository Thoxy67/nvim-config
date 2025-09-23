local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.svelte = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "svelte",
  },
  root_markers = { "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs" },
  settings = {
    svelte = {},
  },
}

vim.lsp.config.vtsls = {
  on_attach = on_attach,
  --enabled = false,
  filetypes = {
    "svelte",
  },
  root_markers = { "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs" },
  settings = {
    vtsls = {},
  },
}

vim.lsp.enable { "svelte", "vtsls" }


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
