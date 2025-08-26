local M = {}

M.hl_override = {
  -- Search count highlights (using base46 color palette)
  St_SearchSep = { fg = "blue", bg = "NONE" },
  St_SearchIcon = { fg = "black", bg = "blue" },
  St_SearchText = { fg = "white", bg = "blue" },

  -- Macro recording highlights
  St_MacroSep = { fg = "red", bg = "NONE" },
  St_MacroIcon = { fg = "black", bg = "red" },
  St_MacroText = { fg = "white", bg = "red" },

  -- RegximMatch = { fg = "white", bg = "red" },
  -- RegximGroup1 = { fg = "#ffffff", bg = "#27ae60", bold = true },
  -- RegximGroup2 = { fg = "#ffffff", bg = "#2980b9", bold = true },
  -- RegximGroup3 = { fg = "#ffffff", bg = "#481463", bold = true },
  -- RegximGroup4 = { fg = "#ffffff", bg = "#d68910", bold = true },
  -- RegximError = { fg = "white", bg = "dark_red" },
}

M.hl_add = {
  RegximGroup5 = { fg = "#ffffff", bg = "#AD2074" },

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

  St_overseer_icon = { fg = "#ffffff", bg = "#000000" },
  St_overseer_sep = { fg = "#000000", bg = "NONE" },
  St_overseer_status = { fg = "#ffffff", bg = "#000000" },
  St_overseer_failure = { fg = "#c0392b", bg = "#000000" }, -- Red with black background
  St_overseer_canceled = { fg = "#f39c12", bg = "#000000" }, -- Orange with black background
  St_overseer_success = { fg = "#229954", bg = "#000000" }, -- Green with black background
  St_overseer_running = { fg = "#2980b9", bg = "#000000" }, -- Blue with black background
}

return M
