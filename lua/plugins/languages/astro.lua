-- ============================================================================
-- ASTRO LANGUAGE SUPPORT
-- lua/plugins/languages/astro.lua
-- ============================================================================
-- Comprehensive Astro framework development environment featuring:
-- - Astro language server for component intelligence
-- - TypeScript/JavaScript support via vtsls integration
-- - Treesitter syntax highlighting for .astro files
-- - Prettier formatting for Astro components
-- - CSS support within <style> tags
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== ASTRO LSP CONFIGURATION ====================
-- Astro language server provides Astro-specific features
vim.lsp.config.astro = {
  on_attach = on_attach,
  filetypes = { "astro" },
  root_markers = {
    "astro.config.js",   -- JavaScript config
    "astro.config.mjs",  -- ES module config
    "astro.config.cjs",  -- CommonJS config
    "astro.config.ts",   -- TypeScript config
  },
}

-- ==================== VTSLS INTEGRATION FOR TYPESCRIPT ====================
-- Extend vtsls (TypeScript) to understand Astro components
-- This enables TypeScript features within code fences in .astro files
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Only integrate if vtsls is the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add @astrojs/ts-plugin for TypeScript awareness in .astro files
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "@astrojs/ts-plugin",
      location = vim.fn.stdpath "data" .. "/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

vim.lsp.enable { "astro" }

return {
  -- Import TypeScript configuration
  { import = "plugins.languages.typescript" },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Astro components
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",  -- Astro component parser
        "css",    -- CSS parser for <style> sections
      },
    },
  },

  -- ==================== FORMATTING CONFIGURATION ====================
  -- Use Prettier for formatting Astro files
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.astro = { "prettier" } -- Prettier has built-in Astro support
    end,
  },
}
