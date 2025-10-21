-- ============================================================================
-- WEB DEVELOPMENT LANGUAGE SUPPORT
-- lua/plugins/languages/web.lua
-- ============================================================================
-- Comprehensive web development environment featuring:
-- - HTML language server for markup validation and completion
-- - CSS language servers for styles, variables, and preprocessing
-- - SASS/SCSS support with somesass_ls
-- - Foundation for web frameworks (used by Vue, Svelte, Astro, etc.)
-- ============================================================================

return {
  -- ==================== WEB LANGUAGE SERVERS ====================
  -- Multiple LSP servers for HTML and CSS development
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},           -- HTML language server (validation, completion, hover)
        css_variable = {},   -- CSS variable support and IntelliSense
        cssls = {},          -- CSS language server (standard CSS features)
        somesass_ls = {},    -- SASS/SCSS language server (preprocessor support)
      },
    },
  },
}
