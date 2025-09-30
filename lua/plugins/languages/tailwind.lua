local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Tailwind CSS LSP configuration with enhanced filetype management
local tailwind_config = {
  on_attach = on_attach,
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    -- Svelte project markers
    "svelte.config.js",
    "svelte.config.mjs",
    "svelte.config.cjs",
    "svelte.config.ts",
    -- Vite project markers
    "vite.config.js",
    "vite.config.mjs",
    "vite.config.cjs",
    "vite.config.ts",
    -- Also look for package.json with tailwindcss dependency
    "package.json",
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elixir = "html-eex",
        eelixir = "html-eex",
        heex = "html-eex",
        svelte = "html",
      },
      experimental = {
        classRegex = {
          -- Support for class: directives in Svelte
          "class:([a-zA-Z0-9\\-:]+)",
          -- Support for clsx/classnames
          {"clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"},
          {"classnames\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"},
        },
      },
    },
  },
  -- Enhanced filetype configuration
  filetypes_exclude = { "markdown" },
  filetypes_include = { "astro" },
}

-- Build filetypes list dynamically
local function setup_tailwind_filetypes()
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

  -- Remove excluded filetypes
  tailwind_config.filetypes = vim.tbl_filter(function(ft)
    return not vim.tbl_contains(tailwind_config.filetypes_exclude or {}, ft)
  end, tailwind_config.filetypes)

  -- Add additional filetypes
  vim.list_extend(tailwind_config.filetypes, tailwind_config.filetypes_include or {})

  -- Remove the helper fields before applying config
  tailwind_config.filetypes_exclude = nil
  tailwind_config.filetypes_include = nil
end

setup_tailwind_filetypes()
vim.lsp.config.tailwindcss = tailwind_config
vim.lsp.enable { "tailwindcss" }

return {
  -- Mason setup to install tailwindcss-language-server
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "tailwindcss-language-server",
      },
    },
  },

  -- Blink integration with tailwindcss colorizer
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- Simple approach: just use the default Blink rendering for now
      -- The colorizer plugin will be handled separately
      return opts
    end,
  },

  -- Add tailwindcss-colorizer as a separate plugin for better color support
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = {},
    config = function()
      -- Set up color highlighting for tailwind classes in the buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.html", "*.vue", "*.svelte", "*.jsx", "*.tsx", "*.css", "*.scss" },
        callback = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
          })
        end,
      })
    end,
  },
}
