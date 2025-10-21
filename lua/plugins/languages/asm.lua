-- ============================================================================
-- ASSEMBLY LANGUAGE SUPPORT
-- lua/plugins/languages/asm.lua
-- ============================================================================
-- Assembly language support featuring:
-- - asm-lsp for instruction documentation and diagnostics
-- - Support for x86, x86_64, ARM, and other architectures
-- - Hover documentation for assembly instructions
-- ============================================================================

return {
  -- ==================== ASM-LSP SERVER ====================
  -- asm-lsp provides language server features for assembly:
  -- - Hover documentation for CPU instructions
  -- - Diagnostics for syntax errors
  -- - Support for multiple assembly syntaxes (AT&T, Intel, ARM, etc.)
  -- - Instruction reference from CPU documentation
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        asm_lsp = {}, -- Assembly language server
      },
    },
  },
}
