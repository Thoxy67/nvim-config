-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
local status_aux = require "custom.statusbar"
local base46_hl = require "custom.base46_hl"

-- ===========================
-- THEME AND APPEARANCE
-- ===========================

M.base46 = {
  transparency = false, -- Set to true for transparent background
  theme = "tokyodark", -- Default theme
  theme_toggle = { "tokyodark", "tokyodark" }, -- Themes for toggle

  hl_override = base46_hl.hl_override,
  hl_add = base46_hl.hl_add,

  integrations = {
    "git",
    "notify",
    "whichkey",
    "lsp",
    "mason",
    "defaults",
    "devicons",
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
    "rainbowdelimiters",
    "grug_far",
    "git-conflict",
    "trouble",
    "tiny-inline-diagnostic",
    "orgmode",
    "leap",
    "flash",
    "diffview",
    "blink",
  },
}

-- ===========================
-- UI CONFIGURATION
-- ===========================

M.ui = {
  cmp = {
    icons_left = true,
    style = "default",
    abbr_maxwidth = 60,
    format_colors = {
      tailwind = true,
      icon = "󱓻",
    },
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
    bufwidth = 21,
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
      -- "git",
      "gitcustom",
      -- "git_ahead_behind",
      "macro_recording",
      "%=",
      "lsp_msg",
      "%=",
      --"diagnostics",
      "custom_diagnostics",
      "lspx",
      "harpoon",
      "overseer_open",
      "custom_cwd",
      -- "cursor",
      "custom_cursor",
    },
    modules = {
      hack = "%#@comment#%",
      macro_recording = status_aux.macro_recording,
      gitcustom = status_aux.git_custom,
      lspx = status_aux.lspx,
      harpoon = status_aux.harpoon_statusline_indicator,
      modified = function()
        return vim.bo.modified and " %#DiagnosticWarn#󰽂 " or " "
      end,
      custom_cwd = status_aux.custom_cwd,
      oil_dir_cwd = "%@OilDirCWD@",
      stop = "%X",
      custom_mode = status_aux.custom_mode,
      custom_diagnostics = status_aux.custom_diagnostics,
      custom_cursor = status_aux.custom_cursor,
      overseer_open = status_aux.overseer_open,
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

  -- header = {
  --   "                      ",
  --   "  ▄▄         ▄ ▄▄▄▄▄▄▄",
  --   "▄▀███▄     ▄██ █████▀ ",
  --   "██▄▀███▄   ███        ",
  --   "███  ▀███▄ ███        ",
  --   "███    ▀██ ███        ",
  --   "███      ▀ ███        ",
  --   "▀██ █████▄▀█▀▄██████▄ ",
  --   "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
  --   "  Powered By  eovim ",
  --   "                      ",
  -- },

  -- header = {
  --   "                                 ",
  --   "           ▄ ▄                   ",
  --   "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  --   "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  --   "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  --   "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  --   "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  --   "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  --   "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  --   "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
  --   "       Powered By  eovim       ",
  -- },

  -- header = {
  --   "                                   ",
  --   "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
  --   "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
  --   "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
  --   "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
  --   "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
  --   "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
  --   "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
  --   " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
  --   " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
  --   "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
  --   "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
  --   "        Powered By  eovim        ",
  --   "                                   ",
  -- },

  -- header = {
  --   [[                                                                       ]],
  --   [[  ██████   █████                   █████   █████  ███                  ]],
  --   [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
  --   [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
  --   [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
  --   [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
  --   [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
  --   [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
  --   [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
  --   [[                                                                       ]],
  -- },

  -- header = {
  --   [[                                                    ]],
  --   [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
  --   [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
  --   [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
  --   [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
  --   [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
  --   [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
  --   [[                                                    ]],
  -- },

  buttons = {
    { txt = " New File", keys = "n", cmd = ":ene | startinsert" },

    { txt = "─", hl = "Normal", no_gap = false, rep = true },

    { txt = "  Find File", keys = "ff", cmd = ":lua require('snacks').dashboard.pick('find_files')" },

    { txt = "  Recent Files", keys = "fo", cmd = ":lua require('snacks').dashboard.pick('oldfiles')" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = ":lua require('snacks').dashboard.pick('live_grep')" },
    { txt = "  Find Projects", keys = "fp", cmd = ":lua require('snacks').dashboard.pick('projects')" },
    { txt = "  Find Session", keys = "fs", cmd = "AutoSession search" },
    --[[     { txt = "  Find Repo", keys = "fr", cmd = "FindRepo" }, ]]
    { txt = "󰏇  Oil", keys = "o", cmd = "Oil" },

    { txt = "─", hl = "Normal", no_gap = false, rep = true },

    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Cheatsheet", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "  Languages Manager", keys = "lt", cmd = "LanguageManager" },
    {
      txt = "  Modify Config",
      keys = "c",
      cmd = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
    },
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
    { txt = "       ᓚᘏᗢ Config by Thoxy", hl = "LazyProgressDone", no_gap = true, rep = false },
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

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

return M
