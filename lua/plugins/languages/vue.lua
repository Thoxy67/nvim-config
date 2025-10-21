-- ============================================================================
-- VUE.JS LANGUAGE SUPPORT
-- lua/plugins/languages/vue.lua
-- ============================================================================
-- Comprehensive Vue.js development environment featuring:
-- - Vue language server (Volar) for component intelligence
-- - Hybrid mode for optimal performance with TypeScript
-- - TypeScript/JavaScript support via vtsls integration
-- - Treesitter syntax highlighting for Vue SFCs
-- - CSS support within <style> tags
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== VUE LSP CONFIGURATION ====================
-- Vue language server (Volar) provides Vue-specific features
vim.lsp.config.vue_ls = {
  on_attach = on_attach,
  --enabled = false, -- Uncomment to disable if needed
  filetypes = { "vue" },
  root_markers = {
    "vue.config.js",  -- Vue 2/3 JavaScript config
    "vue.config.ts",  -- Vue 3 TypeScript config
  },
  settings = {
    vue_ls = {
      init_options = {
        vue = {
          -- Hybrid mode: Use external TypeScript server for better performance
          -- This allows Vue LS to focus on Vue-specific features while
          -- delegating TypeScript features to vtsls
          hybridMode = true,
        },
      },
    },
  },
}

-- ==================== VTSLS INTEGRATION FOR TYPESCRIPT ====================
-- Extend vtsls (TypeScript) to understand Vue Single File Components (SFCs)
-- This enables TypeScript features within <script> and <script setup> tags
vim.schedule(function()
  local vtsls_config = vim.lsp.config.vtsls or {}

  -- Only integrate if vtsls is the selected TypeScript LSP
  if vim.g.typescript_lsp == "vtsls" then
    -- Add vue filetype to vtsls
    vtsls_config.filetypes = vtsls_config.filetypes or {}
    table.insert(vtsls_config.filetypes, "vue")

    -- Add Vue root markers
    vtsls_config.root_markers = vtsls_config.root_markers or {}
    vim.list_extend(vtsls_config.root_markers, {
      "vue.config.js",
      "vue.config.ts",
    })

    -- Initialize nested settings structure
    vtsls_config.settings = vtsls_config.settings or {}
    vtsls_config.settings.vtsls = vtsls_config.settings.vtsls or {}
    vtsls_config.settings.vtsls.tsserver = vtsls_config.settings.vtsls.tsserver or {}
    vtsls_config.settings.vtsls.tsserver.globalPlugins = vtsls_config.settings.vtsls.tsserver.globalPlugins or {}

    -- Add @vue/typescript-plugin for TypeScript awareness in .vue files
    table.insert(vtsls_config.settings.vtsls.tsserver.globalPlugins, {
      name = "@vue/typescript-plugin",
      location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptVersions = true,
    })

    vim.lsp.config.vtsls = vtsls_config
  end
end)

-- Enable both Vue and TypeScript LSPs
vim.lsp.enable { "vue_ls", vim.g.typescript_lsp }

return {
  -- Import TypeScript configuration
  { import = "plugins.languages.typescript" },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Vue Single File Components
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vue",  -- Vue SFC parser
        "css",  -- CSS parser for <style> sections
      },
    },
  },

  -- ==================== MASON TOOL INSTALLATION ====================
  -- Install Vue language server (Volar) via Mason
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "vue-language-server", -- Vue LS (Volar) with TypeScript plugin
      },
    },
  },
}
