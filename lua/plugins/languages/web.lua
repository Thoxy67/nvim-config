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

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== HTML LANGUAGE SERVER ====================
-- HTML language server for markup validation and completion
vim.lsp.config.html = {
  on_attach = on_attach,
  filetypes = { "html", "htmldjango", "blade" },
  settings = {
    html = {
      format = {
        enable = true,
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
}

-- ==================== CSS VARIABLES LANGUAGE SERVER ====================
-- CSS variable support and IntelliSense
vim.lsp.config.css_variables = {
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" },
  settings = {},
}

-- ==================== CSS LANGUAGE SERVER ====================
-- CSS language server for standard CSS features
vim.lsp.config.cssls = {
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore", -- Ignore unknown @ rules for better SCSS/LESS support
      },
    },
    scss = {
      validate = true,
    },
    less = {
      validate = true,
    },
  },
}

-- ==================== SASS/SCSS LANGUAGE SERVER ====================
-- SASS/SCSS language server for preprocessor support
vim.lsp.config.somesass_ls = {
  on_attach = on_attach,
  filetypes = { "scss", "sass" },
  settings = {
    somesass = {
      -- Configuration for SASS/SCSS language server
    },
  },
}

-- Enable all web language servers
vim.lsp.enable { "html", "css_variables", "cssls", "somesass_ls" }

return {}
