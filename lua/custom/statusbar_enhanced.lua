local M = {}

-- Enhanced custom_cursor function with percentage, visual selection info, and better formatting
M.custom_cursor = function()
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local utils = require "nvchad.stl.utils"

  local sep_icons = utils.separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]
  local sep_l = separators["left"]

  -- Get cursor position and buffer info
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local total_lines = vim.fn.line("$")

  -- Calculate percentage through file
  local percentage = math.floor((line / total_lines) * 100)

  -- Format position text
  local pos_text = string.format("%d:%d", line, col)

  -- Add percentage and selection info if in visual mode
  local mode = vim.fn.mode()
  local extra_info = ""

  if mode:match("[vV\22]") then
    -- Visual mode: show selection info
    local start_line = vim.fn.line("v")
    local end_line = line
    local lines_selected = math.abs(end_line - start_line) + 1

    if mode == "V" then
      -- Line-wise visual mode
      extra_info = string.format(" [%dL]", lines_selected)
    elseif mode == "v" then
      -- Character-wise visual mode
      local start_col = vim.fn.col("v")
      local end_col = col
      if lines_selected == 1 then
        local chars_selected = math.abs(end_col - start_col) + 1
        extra_info = string.format(" [%dC]", chars_selected)
      else
        extra_info = string.format(" [%dL]", lines_selected)
      end
    else
      -- Block-wise visual mode
      extra_info = string.format(" [%dL]", lines_selected)
    end
  elseif percentage <= 5 then
    extra_info = " Top"
  elseif percentage >= 95 then
    extra_info = " Bot"
  else
    extra_info = string.format(" %d%%", percentage)
  end

  -- Add column indicator for wide lines
  if col > 80 and vim.o.columns > 100 then
    extra_info = extra_info .. " 󰞷"
  end

  -- Only show enhanced info if window is wide enough
  if vim.o.columns < 80 then
    return "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %l:%v "
  else
    return "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# " .. pos_text .. extra_info .. " "
  end
end

return M