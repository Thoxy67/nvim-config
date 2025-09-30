-- ============================================================================
-- NVCHAD INITIALIZATION
-- init.lua
-- ============================================================================
-- Main configuration entry point for NvChad. Sets up plugin manager,
-- theme system, and loads all necessary configurations.
-- ============================================================================

-- ==================== LEADER KEYS ====================
-- Must be set before any plugins are loaded to ensure proper keymapping
vim.g.mapleader = " " -- Primary leader key (space)
vim.g.maplocalleader = " " -- Local leader key (space)

-- ==================== THEME SYSTEM ====================
-- Base46 cache directory for fast theme loading
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- ==================== PLUGIN MANAGER BOOTSTRAP ====================
-- Automatically install lazy.nvim if not present
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- ==================== PLUGIN SETUP ====================
-- Load lazy.nvim configuration with performance optimizations
local lazy_config = require "configs.lazy"

-- Initialize plugin system with NvChad base and user plugins
require("lazy").setup({
  -- NvChad core functionality (always loaded for UI consistency)
  {
    "NvChad/NvChad",
    lazy = false, -- Load immediately for UI setup
    branch = "v2.5", -- Stable release branch
    import = "nvchad.plugins",
  },
  -- User-defined plugins from lua/plugins/
  { import = "plugins" },
}, lazy_config)

-- Uncomment line below if you have problem with base46 highlight generation to regenerate all
-- require('base46').load_all_highlights()

-- ==================== THEME LOADING ====================
-- Load cached theme files for optimal startup performance
-- These are pre-compiled theme files that load faster than dynamic generation
dofile(vim.g.base46_cache .. "defaults") -- Base color scheme
dofile(vim.g.base46_cache .. "statusline") -- Status line colors
dofile(vim.g.base46_cache .. "devicons") -- File type icons
dofile(vim.g.base46_cache .. "blankline") -- Indentation guides
dofile(vim.g.base46_cache .. "dap") -- Debug adapter colors
dofile(vim.g.base46_cache .. "git") -- Git integration colors

-- ==================== CONFIGURATION LOADING ====================
-- Load core Neovim configurations
require "options" -- Vim options and settings
require "autocmds" -- Auto commands and events
require "custom.vimcmd" -- Custom Vim commands

-- ==================== KEYMAPPING SETUP ====================
-- Schedule keymap loading after UI initialization to prevent conflicts
-- This ensures all plugins are loaded before setting up keybindings
vim.schedule(function()
  require "mappings"
end)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
