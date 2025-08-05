-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  transparency = false, -- Add transparency support (set by terminal)
  theme = "onedark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },

  integrations = {
    "git",
    "notify",
    "whichkey",
    "lsp",
    "mason",
    "defaults",
    "telescope",
    "statusline",
    "neogit",
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },
}

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

    { txt = "─", hl = "Normal", no_gap = false, rep = true },

    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Cheatsheet", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "  Modify Config", keys = "co", cmd = "Config" },
    { txt = "󰚰  Update NvChad", keys = "cu", cmd = "NvUpdate" },

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

M.mason = {
  command = true,
  pkgs = {
    "codelldb",
    "bacon",
    "bacon-ls",
  },
  skip = {
    "rust_analyzer",
    "v-analyzer",
    "zls",
  },
}

return M
