-- ============================================================================
-- CONFORM.NVIM CONFIGURATION
-- lua/configs/conform.lua
-- ============================================================================
-- Conform.nvim provides asynchronous formatting with support for multiple
-- formatters per filetype. This configuration sets up basic formatters
-- and enables format-on-save functionality.
-- ============================================================================

local options = {
  -- ==================== FORMATTERS BY FILETYPE ====================
  -- Define which formatters to use for each file type
  -- Language-specific formatters are configured in their respective language files
  formatters_by_ft = {
    -- Lua formatting with stylua
    lua = { "stylua" },

    -- Web technologies formatting with prettier
    css = { "prettier" },
    html = { "prettier" },

    -- Additional formatters can be added here or in language-specific configs:
    -- javascript = { "prettier" },
    -- typescript = { "prettier" },
    -- json = { "prettier" },
    -- markdown = { "prettier" },
  },

  -- ==================== FORMAT ON SAVE CONFIGURATION ====================
  format_on_save = {
    timeout_ms = 500, -- Maximum time to wait for formatting
    lsp_fallback = true, -- Use LSP formatting if no formatter is configured
  },
}

return options
