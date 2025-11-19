-- ============================================================================
-- ASSEMBLY LANGUAGE SUPPORT
-- lua/plugins/languages/asm.lua
-- ============================================================================
-- Assembly language support featuring:
-- - asm-lsp for instruction documentation and diagnostics
-- - Support for x86, x86_64, ARM, and other architectures
-- - Hover documentation for assembly instructions
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== ASM-LSP SERVER ====================
-- asm-lsp provides language server features for assembly:
-- - Hover documentation for CPU instructions
-- - Diagnostics for syntax errors
-- - Support for multiple assembly syntaxes (AT&T, Intel, ARM, etc.)
-- - Instruction reference from CPU documentation
vim.lsp.config.asm_lsp = {
  on_attach = on_attach,
  filetypes = { "asm", "s", "S", "nasm", "gas" },
  root_markers = { ".git", "Makefile" },
  settings = {
    asm_lsp = {
      -- Assembly LSP configuration
      -- Supports multiple architectures: x86, x86_64, ARM, RISC-V, etc.
    },
  },
}

-- Enable ASM LSP server
vim.lsp.enable { "asm_lsp" }

return {}
