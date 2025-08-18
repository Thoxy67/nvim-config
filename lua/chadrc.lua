-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
local aux = require "custom.chadrc_aux"

-- ===========================
-- THEME AND APPEARANCE
-- ===========================

M.base46 = {
  transparency = false, -- Set to true for transparent background
  theme = "onedark", -- Default theme
  theme_toggle = { "onedark", "catppuccin" }, -- Themes for toggle

  hl_override = {
    -- Search count highlights (using base46 color palette)
    St_SearchSep = { fg = "blue", bg = "NONE" },
    St_SearchIcon = { fg = "black", bg = "blue" },
    St_SearchText = { fg = "white", bg = "blue" },

    -- Macro recording highlights
    St_MacroSep = { fg = "red", bg = "NONE" },
    St_MacroIcon = { fg = "black", bg = "red" },
    St_MacroText = { fg = "white", bg = "red" },

    -- RegexBuilderMatch = { fg = "white", bg = "red" },
    -- RegexBuilderGroup1 = { fg = "#ffffff", bg = "#27ae60", bold = true },
    -- RegexBuilderGroup2 = { fg = "#ffffff", bg = "#2980b9", bold = true },
    -- RegexBuilderGroup3 = { fg = "#ffffff", bg = "#481463", bold = true },
    -- RegexBuilderGroup4 = { fg = "#ffffff", bg = "#d68910", bold = true },
    -- RegexBuilderError = { fg = "white", bg = "dark_red" },
  },
  hl_add = {
    RegexBuilderGroup5 = { fg = "#ffffff", bg = "#AD2074" },

    OilVcsStatusAdded = { fg = "#ffffff", bg = "#27ae60" },
    OilVcsStatusCopied = { fg = "#ffffff", bg = "#3498db" },
    OilVcsStatusDeleted = { fg = "#ffffff", bg = "#e74c3c" },
    OilVcsStatusIgnored = { fg = "#bdc3c7", bg = "#2c3e50" },
    OilVcsStatusModified = { fg = "#2c3e50", bg = "#f39c12" },
    OilVcsStatusRenamed = { fg = "#ffffff", bg = "#9b59b6" },
    OilVcsStatusTypeChanged = { fg = "#ffffff", bg = "#d35400" },
    OilVcsStatusUnmodified = { fg = "#2c3e50", bg = "#ecf0f1" },
    OilVcsStatusUnmerged = { fg = "#ffffff", bg = "#c0392b" },
    OilVcsStatusUntracked = { fg = "#ffffff", bg = "#7f8c8d" },
    OilVcsStatusExternal = { fg = "#ffffff", bg = "#34495e" },

    OilVcsStatusUpstreamAdded = { fg = "#ffffff", bg = "#229954" },
    OilVcsStatusUpstreamCopied = { fg = "#ffffff", bg = "#2980b9" },
    OilVcsStatusUpstreamDeleted = { fg = "#ffffff", bg = "#cb4335" },
    OilVcsStatusUpstreamIgnored = { fg = "#bdc3c7", bg = "#34495e" },
    OilVcsStatusUpstreamModified = { fg = "#2c3e50", bg = "#e67e22" },
    OilVcsStatusUpstreamRenamed = { fg = "#ffffff", bg = "#8e44ad" },
    OilVcsStatusUpstreamTypeChanged = { fg = "#ffffff", bg = "#ca6f1e" },
    OilVcsStatusUpstreamUnmodified = { fg = "#34495e", bg = "#f8f9fa" },
    OilVcsStatusUpstreamUnmerged = { fg = "#ffffff", bg = "#a93226" },
    OilVcsStatusUpstreamUntracked = { fg = "#ffffff", bg = "#6c7b7f" },
    OilVcsStatusUpstreamExternal = { fg = "#ffffff", bg = "#2e4057" },
  },

  integrations = {
    "git",
    "notify",
    "whichkey",
    "lsp",
    "mason",
    "defaults",
    "devicons",
    "mini-icons",
    "telescope",
    "statusline",
    "neogit",
    "todo",
    "nvimtree",
    "blankline",
    "markview",
    "vim-illuminate",
    "dap",
    "cmp",
    "semantic_tokens",
    "codeactionmenu",
    "hop",
    "rainbowdelimiters",
    "grug_far",
    "git-conflict",
  },
}

-- ===========================
-- UI CONFIGURATION
-- ===========================

M.ui = {
  cmp = {
    style = "default",
  },
  tabufline = {
    lazyload = false,
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = {
      "custom_mode",
      --"mode",
      -- "f",
      "file",
      "modified",
      "gitcustom",
      -- "git_ahead_behind",
      "macro_recording",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lspx",
      "harpoon",
      "custom_cwd",
      "cursor",
    },
    modules = {
      hack = "%#@comment#%",
      macro_recording = aux.macro_recording,
      gitcustom = aux.git_custom,
      lspx = aux.lspx,
      harpoon = aux.harpoon_statusline_indicator,
      modified = function()
        return vim.bo.modified and " %#DiagnosticWarn#󰽂 " or " "
      end,
      custom_cwd = aux.custom_cwd,
      oil_dir_cwd = "%@OilDirCWD@",
      stop = "%X",
      custom_mode = aux.custom_mode,
      -- git_ahead_behind = aux.git_ahead_behind,
      -- f = "%F",
    },
  },
}

-- ===========================
-- DASHBOARD CONFIGURATION
-- ===========================

M.nvdash = {
  load_on_startup = true,
  header = {
    "                      ",
    "  ▄▄         ▄ ▄▄▄▄▄▄▄",
    "▄▀███▄     ▄██ █████▀ ",
    "██▄▀███▄   ███        ",
    "███  ▀███▄ ███        ",
    "███    ▀██ ███        ",
    "███      ▀ ███        ",
    "▀██ █████▄▀█▀▄██████▄ ",
    "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
    "  Powered By  eovim ",
    "                      ",
  },

  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "  Find Projects", keys = "fp", cmd = "Proot" },
    { txt = "  Find Session", keys = "fs", cmd = "SessionSearch" },
    { txt = "  Find Repo", keys = "fr", cmd = "FindRepo" },
    { txt = "󰏇  Oil", keys = "o", cmd = "Oil" },

    { txt = "─", hl = "Normal", no_gap = false, rep = true },

    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Cheatsheet", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "  Modify Config", keys = "C", cmd = "NvConfig" },
    { txt = "󰚰  Update", keys = "U", cmd = "NvUpdate" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    { txt = "ᓚᘏᗢ Config by Thoxy", hl = "LazyProgressDone", no_gap = true, rep = false },
  },
}

-- ===========================
-- PACKAGE MANAGEMENT
-- ===========================

M.mason = {
  command = true, -- Enable Mason command
  skip = { -- Skip these packages (install manually)
    "rust_analyzer",
    "v-analyzer",
    "zls",
    "clangd",
  },
}

-- ===========================
-- LSP CONFIGURATION
-- ===========================

M.lsp = {
  signature = true, -- Enable signature help
}

-- ===========================
-- CHEATSHEET
-- ===========================

M.cheatsheet = {
  theme = "grid", -- simple/grid
  excluded_groups = {}, -- Groups to exclude
}

return M
