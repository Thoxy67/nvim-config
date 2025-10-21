-- ============================================================================
-- TAILWIND CSS LANGUAGE SUPPORT
-- lua/plugins/languages/tailwind.lua
-- ============================================================================
-- Comprehensive Tailwind CSS development environment featuring:
-- - Tailwind CSS IntelliSense with class name completion
-- - Color preview for Tailwind color utilities
-- - Support for custom class patterns (clsx, classnames, Svelte class: directives)
-- - Integration with multiple frameworks (Svelte, Vue, Astro, React)
-- - Enhanced filetype detection and project marker support
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== TAILWIND LSP CONFIGURATION ====================
-- Tailwind CSS Language Server provides IntelliSense for Tailwind classes
local tailwind_config = {
  on_attach = on_attach,
  -- Project markers to detect Tailwind projects
  root_markers = {
    -- Tailwind config files
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    -- PostCSS config files (often used with Tailwind)
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    -- Svelte project markers
    "svelte.config.js",
    "svelte.config.mjs",
    "svelte.config.cjs",
    "svelte.config.ts",
    -- Vite project markers (common in modern web projects)
    "vite.config.js",
    "vite.config.mjs",
    "vite.config.cjs",
    "vite.config.ts",
    -- Fallback: look for package.json with tailwindcss dependency
    "package.json",
  },
  settings = {
    tailwindCSS = {
      -- Language mappings for non-standard file types
      includeLanguages = {
        elixir = "html-eex",   -- Phoenix/Elixir support
        eelixir = "html-eex",  -- Embedded Elixir
        heex = "html-eex",     -- Phoenix LiveView
        svelte = "html",       -- Svelte components
      },
      -- Experimental features for better class detection
      experimental = {
        classRegex = {
          -- Support for Svelte's class: directives (class:active="condition")
          "class:([a-zA-Z0-9\\-:]+)",
          -- Support for clsx() utility
          { "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          -- Support for classnames() utility
          { "classnames\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
    },
  },
  -- Filetype management configuration
  filetypes_exclude = { "markdown" },  -- Exclude markdown files
  filetypes_include = { "astro" },     -- Include Astro files
}

-- ==================== DYNAMIC FILETYPE CONFIGURATION ====================
-- Build filetypes list dynamically based on include/exclude lists
local function setup_tailwind_filetypes()
  -- Default file types where Tailwind IntelliSense should work
  local default_filetypes = {
    "css",
    "scss",
    "sass",
    "html",
    "vue",
    "svelte",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  }

  -- Start with default filetypes
  tailwind_config.filetypes = vim.deepcopy(default_filetypes)

  -- Remove excluded filetypes (e.g., markdown)
  tailwind_config.filetypes = vim.tbl_filter(function(ft)
    return not vim.tbl_contains(tailwind_config.filetypes_exclude or {}, ft)
  end, tailwind_config.filetypes)

  -- Add additional filetypes (e.g., astro)
  vim.list_extend(tailwind_config.filetypes, tailwind_config.filetypes_include or {})

  -- Clean up helper fields before applying config
  tailwind_config.filetypes_exclude = nil
  tailwind_config.filetypes_include = nil
end

setup_tailwind_filetypes()
vim.lsp.config.tailwindcss = tailwind_config
vim.lsp.enable { "tailwindcss" }

return {
  -- ==================== MASON TOOL INSTALLATION ====================
  -- Install Tailwind CSS Language Server via Mason
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "tailwindcss-language-server", -- Tailwind IntelliSense
      },
    },
  },

  -- ==================== COMPLETION INTEGRATION ====================
  -- Blink completion integration (placeholder for future customization)
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- Use default Blink rendering
      -- Colorizer plugin handles color previews separately
      return opts
    end,
  },

  -- ==================== COLOR PREVIEW ====================
  -- Display color previews for Tailwind color utilities
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = {},
    config = function()
      -- Set up color highlighting for Tailwind classes in supported file types
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.html", "*.vue", "*.svelte", "*.jsx", "*.tsx", "*.css", "*.scss" },
        callback = function()
          require("tailwindcss-colorizer-cmp").setup {
            color_square_width = 2, -- Width of color preview squares
          }
        end,
      })
    end,
  },
}
