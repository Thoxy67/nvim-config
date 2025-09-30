local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.astro = {
  on_attach = on_attach,
  filetypes = { "astro" },
  root_markers = {
    "astro.config.js",
    "astro.config.mjs",
    "astro.config.cjs",
    "astro.config.ts",
  },
}

-- Extend vtsls configuration to add Astro plugin support
-- We need to defer this until after TypeScript config is loaded
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Add astro plugin to vtsls if it's the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add astro plugin to globalPlugins
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "@astrojs/ts-plugin",
      location = vim.fn.stdpath("data") .. "/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

vim.lsp.enable { "astro" }

return {
  { import = "plugins.languages.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "astro", "css" } },
  },
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.astro = { "prettier" }
    end,
  },
}
