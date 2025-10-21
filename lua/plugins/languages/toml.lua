-- ============================================================================
-- TOML LANGUAGE SUPPORT
-- lua/plugins/languages/toml.lua
-- ============================================================================
-- TOML configuration file support featuring:
-- - Taplo LSP for validation, formatting, and diagnostics
-- - Support for Cargo.toml, pyproject.toml, and other TOML configs
-- ============================================================================

return {
  -- ==================== TAPLO LSP SERVER ====================
  -- Taplo provides comprehensive TOML language features:
  -- - Syntax validation and error checking
  -- - Schema validation (e.g., Cargo.toml structure validation)
  -- - Auto-formatting
  -- - Hover documentation
  -- - Completion for known keys
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {}, -- Taplo TOML LSP server
      },
    },
  },
}
