-- ============================================================================
-- NEOVIM OPTIONS CONFIGURATION
-- lua/options.lua
-- ============================================================================
-- This file contains custom Neovim options that extend NvChad's defaults.
-- Options are organized by category for easy maintenance and understanding.
-- ============================================================================

-- Load NvChad's default options first
require "nvchad.options"

-- ============================================================================
-- VISUAL AND UI ENHANCEMENTS
-- ============================================================================

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = true

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
vim.g.trouble_lualine = true

-- ==================== CURSOR AND LINE DISPLAY ====================
-- Show which line your cursor is on with highlighting
vim.o.cursorline = true
vim.o.cursorlineopt = "both" -- Highlight both line number and line content

-- Enable 24-bit color support for better themes
vim.opt.termguicolors = true

-- ==================== LINE NUMBERING ====================
-- Make line numbers default (essential for navigation)
vim.o.number = true

-- Uncomment for relative line numbers (helpful for motions like 5j, 3k)
-- vim.o.relativenumber = true

-- ==================== FONT AND ICON SUPPORT ====================
-- Set to true if you have a Nerd Font installed and selected in terminal
-- Nerd Fonts provide icons for file types, Git status, etc.
vim.g.have_nerd_font = true

-- ============================================================================
-- PERFORMANCE AND MEMORY OPTIMIZATION
-- ============================================================================

-- ==================== BUFFER MANAGEMENT ====================
-- Reduce memory usage by limiting buffer history
vim.o.undolevels = 1000 -- Limit undo levels
vim.o.undoreload = 10000 -- Limit undo reload size

-- ==================== SEARCH OPTIMIZATION ====================
-- Improve search performance
vim.o.incsearch = true -- Incremental search
vim.o.hlsearch = true -- Highlight search results

-- ============================================================================
-- INPUT AND INTERACTION
-- ============================================================================

-- ==================== MOUSE SUPPORT ====================
-- Enable mouse mode (useful for resizing splits, selecting text)
vim.o.mouse = "a"

-- ==================== MODE DISPLAY ====================
-- Don't show mode in command line (already shown in statusline)
vim.o.showmode = false

-- ==================== CLIPBOARD INTEGRATION ====================
-- Sync clipboard between OS and Neovim for seamless copy/paste
-- Scheduled after UiEnter to avoid startup time impact
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- ============================================================================
-- EDITING BEHAVIOR
-- ============================================================================

-- ==================== INDENTATION ====================
-- Enable break indent (wrapped lines maintain indentation)
vim.o.breakindent = true

-- ==================== UNDO HISTORY ====================
-- Save undo history to files (persistent across sessions)
vim.o.undofile = true

-- ==================== SEARCH BEHAVIOR ====================
-- Case-insensitive searching UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview substitutions live as you type (show changes before confirming)
vim.o.inccommand = "split"

-- ============================================================================
-- EDITOR INTERFACE
-- ============================================================================

-- ==================== SIGN COLUMN ====================
-- Keep sign column visible by default (for Git signs, diagnostics, etc.)
vim.o.signcolumn = "yes"

-- ==================== TIMING AND RESPONSIVENESS ====================
-- Decrease update time for faster completion and Git signs
vim.o.updatetime = 250

-- Decrease mapped sequence wait time (faster which-key popup)
vim.o.timeoutlen = 300

-- ==================== WINDOW SPLITS ====================
-- Configure how new splits should be opened (more intuitive)
vim.o.splitright = true -- Vertical splits open to the right
vim.o.splitbelow = true -- Horizontal splits open below

-- ==================== SWAP FILES ====================
-- Prevent use of swap files (modern systems have enough RAM)
vim.opt.swapfile = false

-- ============================================================================
-- WHITESPACE AND FORMATTING
-- ============================================================================

-- ==================== WHITESPACE VISUALIZATION ====================
-- Configure how whitespace characters are displayed
-- Using vim.opt for better table interface
vim.o.list = true
vim.opt.listchars = {
  -- space = "·",     -- Show spaces as dots (uncomment if needed)
  tab = "» ", -- Show tabs as » followed by space
  nbsp = "␣", -- Show non-breaking spaces
  trail = "·", -- Show trailing spaces as dots
}

-- ============================================================================
-- SCROLLING AND NAVIGATION
-- ============================================================================

-- ==================== SCROLL OFFSET ====================
-- Minimal number of screen lines to keep above and below cursor
-- Keeps context visible when scrolling
vim.o.scrolloff = 10

-- ============================================================================
-- FILE HANDLING
-- ============================================================================

-- ==================== SAVE BEHAVIOR ====================
-- Show confirmation dialog for operations that would fail due to unsaved changes
-- Instead of just failing, ask if you want to save first
vim.o.confirm = true

-- ============================================================================
-- EXTERNAL TOOL INTEGRATION
-- ============================================================================

-- ==================== PYTHON INTEGRATION ====================
-- Path to Python 3 for plugins that require Python support
-- Install python-pynvim: pip install pynvim (or use system package)
vim.g.python3_host_prog = "/usr/bin/python3"

-- ==================== NODE.JS INTEGRATION ====================
-- Path to Node.js host for plugins that require Node.js support
-- Install neovim package: npm install -g neovim (or bun i -g neovim)
vim.g.node_host_prog = "/home/thoxy/.bun/bin/neovim-node-host"

-- ==================== PROVIDER INITIALIZATION ====================
-- Enable external language providers
local enable_providers = {
  "python3_provider", -- Python provider for plugins
  "node_provider", -- Node.js provider for plugins
}

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Load providers that were previously disabled
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil -- Unmark as loaded
  vim.cmd("runtime " .. plugin) -- Load the provider
end

if vim.fn.getenv "TERM_PROGRAM" == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%F"
end

-- treesitter indentation
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.o.mousemoveevent = true

-- ==================== LSP SERVER SELECTION ====================

-- Configure which PHP LSP server to use
vim.g.lazyvim_php_lsp = "intelephense" -- LSP: "phpactor" or "intelephense"

-- Configure which Ruby LSP server and formatter to use
vim.g.lazyvim_ruby_lsp = "ruby_lsp" -- LSP: "ruby_lsp" or "solargraph"
vim.g.lazyvim_ruby_formatter = "rubocop" -- Formatter: "rubocop" or "standardrb"
