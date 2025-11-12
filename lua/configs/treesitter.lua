-- ============================================================================
-- TREESITTER CONFIGURATION
-- lua/configs/treesitter.lua
-- ============================================================================
-- Tree-sitter configuration for syntax highlighting, incremental selection,
-- and text object movements.
-- ============================================================================

return {
  -- Lazy load parsers for better startup performance
  -- Only install parsers when needed
  ensure_installed = {
     "bash",
     "c",
     "diff",
     "fish",
     "html",
     "javascript",
     "jsdoc",
     "json",
     "jsonc",
     "lua",
     "luadoc",
     "luap",
     "markdown",
     "markdown_inline",
     "printf",
     "python",
     "query",
     "regex",
     "toml",
     "tsx",
     "typescript",
     "vim",
     "vimdoc",
     "xml",
     "yaml",
     "css",
     "latex",
     "norg",
     "norg_meta",
     "scss",
     "svelte",
     "typst",
     "vue",
     -- Additional web-related languages
     "astro",
     "prisma",
     "graphql",
   },

  -- Selection enhancement
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },

  -- Text object movements
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
      },
    },
  },
}