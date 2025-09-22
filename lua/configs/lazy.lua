-- ============================================================================
-- LAZY.NVIM CONFIGURATION
-- lua/configs/lazy.lua
-- ============================================================================
-- Configuration for the Lazy.nvim plugin manager, including performance
-- optimizations, UI customization, and automatic update checking.
-- ============================================================================

return {
  -- ==================== DEFAULT PLUGIN BEHAVIOR ====================
  defaults = {
    lazy = true, -- Enable lazy loading by default for better performance
    -- version = false, -- Don't pin to specific versions (use latest)
  },

  -- ==================== INSTALLATION SETTINGS ====================
  install = {
    colorscheme = { "nvchad" }, -- Use NvChad colorscheme during installation
  },

  -- ==================== UI CUSTOMIZATION ====================
  ui = {
    icons = {},
  },

  -- ==================== AUTOMATIC UPDATE CHECKING ====================
  checker = {
    enabled = true, -- Periodically check for plugin updates
    notify = true, -- Show notifications when updates are available
  },

  -- ==================== PERFORMANCE OPTIMIZATIONS ====================
  performance = {
    rtp = {
      -- Disable built-in Vim plugins that are not needed
      -- This improves startup time by not loading unnecessary functionality
      disabled_plugins = {
        -- HTML plugins
        "2html_plugin",
        "tohtml",

        -- Script downloading
        "getscript",
        "getscriptPlugin",

        -- Compression
        "gzip",

        -- Pattern matching
        "logipat",

        -- Network file explorer (replaced by oil.nvim/yazi)
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",

        -- Bracket matching (replaced by vim-matchup)
        "matchit",

        -- Archive handling
        "tar",
        "tarPlugin",
        "rrhelper",

        -- Spell checking
        "spellfile_plugin",

        -- Vimball archives
        "vimball",
        "vimballPlugin",

        -- ZIP archives
        "zip",
        "zipPlugin",

        -- Tutorial and help
        "tutor",

        -- Remote plugins
        "rplugin",

        -- Syntax highlighting (using treesitter instead)
        "syntax",
        "synmenu",

        -- Options window
        "optwin",

        -- Compiler support
        "compiler",

        -- Bug reporting
        "bugreport",

        -- File type plugins (using custom configurations)
        "ftplugin",
      },
    },
  },
}
