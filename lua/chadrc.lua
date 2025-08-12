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
      "mode",
      -- "f",
      "file",
      "modified",
      "gitcustom",
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
      gitcustom = aux.git_custom,
      lspx = aux.lspx,
      harpoon = aux.harpoon_statusline_indicator,
      modified = function()
        return vim.bo.modified and " %#DiagnosticWarn#󰽂 " or " "
      end,
      custom_cwd = aux.custom_cwd,
      oil_dir_cwd = "%@OilDirCWD@",
      stop = "%X",
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
    "                      ",
    "  Powered By  eovim ",
    "                      ",
  },

  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "  Find Projects", keys = "fp", cmd = "Proot" },
    { txt = "  Find Session", keys = "fs", cmd = "SessionSearch" },

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
