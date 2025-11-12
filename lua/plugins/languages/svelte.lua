-- ============================================================================
-- SVELTE LANGUAGE SUPPORT
-- lua/plugins/languages/svelte.lua
-- ============================================================================
-- Comprehensive Svelte development environment featuring:
-- - Svelte language server for component intelligence
-- - TypeScript/JavaScript support via vtsls integration
-- - Treesitter syntax highlighting for .svelte files
-- - Automatic detection of Svelte projects via svelte.config files
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== SVELTE LSP CONFIGURATION ====================
-- Svelte language server provides Svelte-specific features
vim.lsp.config.svelte = {
  on_attach = on_attach,
  --enabled = false, -- Uncomment to disable if needed
  filetypes = { "svelte" },
  root_markers = {
    "svelte.config.js",   -- JavaScript config
    "svelte.config.mjs",  -- ES module config
    "svelte.config.cjs",  -- CommonJS config
  },
  settings = {
    svelte = {}, -- Svelte-specific settings
  },
}

-- ==================== VTSLS INTEGRATION FOR TYPESCRIPT ====================
-- Extend vtsls (TypeScript) to understand Svelte components
-- This enables TypeScript features within <script> tags in .svelte files
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Only integrate if vtsls is the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    -- Add svelte filetype to vtsls
    vtsls_config.filetypes = vtsls_config.filetypes or {}
    table.insert(vtsls_config.filetypes, "svelte")

    -- Add Svelte root markers
    vtsls_config.root_markers = vtsls_config.root_markers or {}
    vim.list_extend(vtsls_config.root_markers, {
      "svelte.config.js",
      "svelte.config.mjs",
      "svelte.config.cjs",
    })

    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add typescript-svelte-plugin for TypeScript awareness in .svelte files
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "typescript-svelte-plugin",
      location = vim.fn.stdpath "data" .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

-- Enable both Svelte and TypeScript LSPs
vim.lsp.enable { "svelte", vim.g.typescript_lsp }

return {
  -- Import TypeScript configuration
  { import = "plugins.languages.typescript" },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Svelte components
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "svelte" } }, -- Svelte parser
  },

  -- ==================== MASON TOOL INSTALLATION ====================
  -- Install Svelte language server and formatter via Mason
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "svelte-language-server", -- Svelte LS with TypeScript plugin
        "prettier", -- Code formatter for Svelte and other web languages
      },
    },
  },
}
