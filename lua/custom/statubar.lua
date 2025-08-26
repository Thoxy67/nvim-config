local M = {}

-- Get the buffer number for the current statusline window
-- This ensures statusline components show information for the correct buffer
M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

-- Custom Git status component with clickable branch and change indicators
-- Shows: branch name, added lines, modified lines, deleted lines
-- Integrates with gitsigns.nvim for real-time Git status
M.git_custom = function()
  local run = "%@RunNeogit@" -- Clickable area start (opens Neogit)
  local stop = "%X" -- Clickable area end

  local bufnr = M.stbufnr()
  if not vim.b[bufnr].gitsigns_head or vim.b[bufnr].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[bufnr].gitsigns_status_dict
  local clear_hl = "%#St_gitIcons#"
  local add_hl = "%#St_LspInfo#"
  local changed_hl = "%#St_lspWarning#"
  local rm_hl = "%#St_lspError#"
  local branch_hl = "%#St_gitIcons#"

  local added = (git_status.added and git_status.added ~= 0) and (add_hl .. "  " .. clear_hl .. git_status.added)
    or ""
  local changed = (git_status.changed and git_status.changed ~= 0)
      and (changed_hl .. "  " .. clear_hl .. git_status.changed)
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0)
      and (rm_hl .. "  " .. clear_hl .. git_status.removed)
    or ""
  local branch_name = branch_hl .. " " .. git_status.head .. clear_hl

  return run .. " " .. branch_name .. " " .. added .. changed .. removed .. stop .. " ╱"
end

M.lspx = function()
  local count = 0
  local display = ""
  local run = "%@LspHealthCheck@"
  local stop = "%X"

  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)] then
        count = count + 1
        display = (vim.o.columns > 100 and run .. " %#St_Lsp#  LSP ~ " .. client.name .. " " .. stop)
          or run .. " %#St_Lsp#  LSP " .. stop
      end
    end
  end

  if count > 1 then
    return run .. " %#St_Lsp#  LSP (" .. count .. ") " .. stop
  else
    return display
  end
end

M.harpoon_statusline_indicator = function()
  -- inspiration from https://github.com/letieu/harpoon-lualine
  local run = "%@RunHarpoon@"
  local stop = "%X"
  local inactive = "%#St_HarpoonInactive#"
  local active = "%#St_HarpoonActive#"

  local options = {
    icon = active .. " 󰛢 ",
    separator = "",
    indicators = {
      inactive .. "q",
      inactive .. "w",
      inactive .. "e",
      inactive .. "r",
      inactive .. "t",
      inactive .. "y",
    },
    active_indicators = {
      active .. "1",
      active .. "2",
      active .. "3",
      active .. "4",
      active .. "5",
      active .. "6",
    },
  }

  local list = require("harpoon"):list()
  local root_dir = list.config:get_root_dir()
  local current_file_path = vim.api.nvim_buf_get_name(0)
  local length = math.min(list:length(), #options.indicators)
  local status = { options.icon }

  local get_full_path = function(root, value)
    if vim.uv.os_uname().sysname == "Windows_NT" then
      return root .. "\\" .. value
    end

    return root .. "/" .. value
  end

  for i = 1, length do
    local value = list:get(i).value
    local full_path = get_full_path(root_dir, value)

    if full_path == current_file_path then
      table.insert(status, options.active_indicators[i])
    else
      table.insert(status, options.indicators[i])
    end
  end

  if length > 0 then
    table.insert(status, " ")
    return run .. table.concat(status, options.separator) .. stop
  else
    return ""
  end
end

M.custom_cwd = function()
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local utils = require "nvchad.stl.utils"

  local sep_icons = utils.separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

  local sep_l = separators["left"]

  local icon = "%#St_cwd_icon#" .. "󰉋 "
  local run = "%@OpenDir@"
  local stop = "%X"

  local name = vim.uv.cwd()
  name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
  return (vim.o.columns > 85 and run .. ("%#St_cwd_sep#" .. sep_l .. icon .. name) .. stop) or ""
end

M.custom_mode = function()
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local utils = require "nvchad.stl.utils"

  local sep_icons = utils.separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

  local sep_r = separators["right"]

  if not utils.is_activewin() then
    return ""
  end

  local modes = utils.modes

  local m = vim.api.nvim_get_mode().mode

  local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1]
  local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
  return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
end

M.macro_recording = function()
  local recording = vim.fn.reg_recording()
  if recording ~= "" then
    return "%#DiagnosticError#  Recording @" .. recording .. " "
  end
  return ""
end

M.custom_diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local err = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.INFO })

  local run = "%@Trouble@"
  local stop = "%X"

  err = (err and err > 0) and (run .. "%#St_lspError#" .. " " .. err .. " " .. stop) or ""
  warn = (warn and warn > 0) and (run .. "%#St_lspWarning#" .. " " .. warn .. " " .. stop) or ""
  hints = (hints and hints > 0) and (run .. "%#St_lspHints#" .. "󰛨 " .. hints .. " " .. stop) or ""
  info = (info and info > 0) and (run .. "%#St_lspInfo#" .. "󰋼 " .. info .. " " .. stop) or ""

  return " " .. err .. warn .. hints .. info
end

M.custom_cursor = function()
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local utils = require "nvchad.stl.utils"

  local sep_icons = utils.separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

  local sep_l = separators["left"]
  return "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %l:%v "
end

M.overseer_open = function()
  local config = require("nvconfig").ui.statusline
  local sep_style = config.separator_style
  local utils = require "nvchad.stl.utils"
  local sep_icons = utils.separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]
  local sep_l = separators["left"]

  -- Get Overseer status
  local ok, overseer = pcall(require, "overseer")
  local status_text = ""

  if ok then
    local tasks = overseer.list_tasks()
    local status_counts = {
      [overseer.STATUS.FAILURE] = 0,
      [overseer.STATUS.CANCELED] = 0,
      [overseer.STATUS.SUCCESS] = 0,
      [overseer.STATUS.RUNNING] = 0,
    }

    -- Count tasks by status
    for _, task in ipairs(tasks) do
      if task and type(task) == "table" then
        local status = task.status
        if status and status_counts[status] then
          status_counts[status] = status_counts[status] + 1
        end
      end
    end

    -- Build status display
    local status_parts = {}
    local status_config = {
      [overseer.STATUS.FAILURE] = { icon = " :", highlight = "%#St_overseer_failure#" },
      [overseer.STATUS.CANCELED] = { icon = "󰜺 :", highlight = "%#St_overseer_canceled#" },
      [overseer.STATUS.SUCCESS] = { icon = " :", highlight = "%#St_overseer_success#" },
      [overseer.STATUS.RUNNING] = { icon = " :", highlight = "%#St_overseer_running#" },
    }

    -- Add non-zero counts to display with colors
    for status, count in pairs(status_counts) do
      if count > 0 then
        local c = status_config[status]
        table.insert(status_parts, c.highlight .. c.icon .. count .. "%#St_overseer_status#")
      end
    end

    if #status_parts > 0 then
      status_text = " " .. table.concat(status_parts, " ") .. " "
    else
      -- Show 0 if no tasks exist
      status_text = " 0 "
    end
  end
  local icon = "%#St_overseer_icon#" .. "󰑮 "
  local run = "%@OverseerToggle@"
  local stop = "%X"

  -- Include status in the display
  local status_display = status_text ~= "" and "%#St_overseer_status#" .. status_text or ""

  return (
    vim.o.columns > 85
    and run
      .. ("%#St_overseer_sep#" .. sep_l .. icon .. status_display .. "%#St_overseer_sep#" .. "")
      .. stop
      .. " "
  ) or ""
end

return M
