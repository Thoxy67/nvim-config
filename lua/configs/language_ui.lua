local M = {}
local lang_manager = require "configs.language_manager"

-- Create the language toggle UI with multi-selection support
function M.show_language_manager()
  -- Prepare items for selection
  local items = {}
  local display_items = {}

  for i, lang_info in ipairs(lang_manager.available_languages) do
    local is_enabled = lang_manager.is_enabled(lang_info.name)
    local status = is_enabled and "✓" or "✗"

    table.insert(items, {
      index = i,
      name = lang_info.name,
      display = lang_info.display,
      path = lang_info.path,
      enabled = is_enabled,
    })

    table.insert(display_items, string.format("%2d. %s %s", i, status, lang_info.display))
  end

  -- Create custom highlight groups
  local function setup_highlights()
    vim.api.nvim_set_hl(0, "LanguageManagerTitle", { fg = "#7dcfff", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerEnabled", { fg = "#9ece6a", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerDisabled", { fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerNumber", { fg = "#bb9af7" })
    vim.api.nvim_set_hl(0, "LanguageManagerOption", { fg = "#e0af68" })
    vim.api.nvim_set_hl(0, "LanguageManagerBorder", { fg = "#7aa2f7" })
  end

  setup_highlights()

  -- Create a floating window with the menu
  local menu_lines = { "  Select the language to enable or disable :", "" }
  for _, item in ipairs(display_items) do
    table.insert(menu_lines, item)
  end
  table.insert(menu_lines, "")
  table.insert(menu_lines, "⚙️  Options:")
  table.insert(menu_lines, "• Single: Select number (e.g., '3')")
  table.insert(menu_lines, "• Multiple: Space-separated (e.g., '1 3 5') or comma-separated (e.g., '1,3,5')")
  table.insert(menu_lines, "• Range: Use hyphen (e.g., '1-5' or '2-4')")
  table.insert(menu_lines, "• All: Type 'all' to enable all languages")
  table.insert(menu_lines, "• None: Type 'none' to disable all languages")
  table.insert(menu_lines, "• Cancel: Press <Esc> or leave empty")

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, menu_lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  -- Calculate window size
  local width = vim.o.columns - 10
  local height = math.min(#menu_lines + 2, vim.o.lines - 8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Window options
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = "   Language Plugin Manager ",
    title_pos = "center",
  }

  local win = vim.api.nvim_open_win(buf, false, opts)

  -- Add colorful highlighting
  vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:LanguageManagerBorder", { win = win })

  -- Apply syntax highlighting to the buffer
  local ns_id = vim.api.nvim_create_namespace "LanguageManager"

  -- Highlight title
  vim.hl.range(buf, ns_id, "LanguageManagerTitle", { 0, 0 }, { 0, -1 })

  -- Highlight language entries
  for i, item in ipairs(items) do
    local line_idx = i + 1 -- +1 because of title and empty line
    local status_symbol = item.enabled and "✓" or "✗"
    local hl_group = item.enabled and "LanguageManagerEnabled" or "LanguageManagerDisabled"

    -- Highlight the number
    vim.hl.range(buf, ns_id, "LanguageManagerNumber", { line_idx, 0 }, { line_idx, 3 })

    -- Highlight the status symbol
    local status_start = string.find(display_items[i], status_symbol)
    if status_start then
      vim.hl.range(buf, ns_id, hl_group, { line_idx, status_start - 1 }, { line_idx, status_start })
    end
  end

  -- Highlight options section
  local options_start = #items + 3 -- +3 for title, empty line, and another empty line
  vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start, 0 }, { options_start, -1 })

  -- Highlight each option line
  for i = 1, 6 do -- 6 option lines now (added 'none' command)
    vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start + i, 0 }, { options_start + i, 1 })
  end

  -- Show input prompt
  vim.ui.input({
    prompt = "Select languages to toggle: ",
  }, function(input)
    -- Close the floating window
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end

    if input and input ~= "" then
      M.process_multi_selection(input, items)
    end
  end)
end

-- Process multi-selection input
function M.process_multi_selection(input, items)
  local selections = {}
  local bulk_action = nil

  -- Handle bulk commands
  local lower_input = string.lower(input)
  if lower_input == "all" then
    bulk_action = "enable_all"
    for i = 1, #items do
      table.insert(selections, i)
    end
  elseif lower_input == "none" then
    bulk_action = "disable_all"
    for i = 1, #items do
      table.insert(selections, i)
    end
  else
    -- Parse input for numbers, ranges, and separators
    local cleaned_input = input:gsub("%s+", " "):gsub(",", " ")

    for part in cleaned_input:gmatch "%S+" do
      if part:match "^%d+$" then
        -- Single number
        local num = tonumber(part)
        if num and num >= 1 and num <= #items then
          table.insert(selections, num)
        end
      elseif part:match "^%d+%-%d+$" then
        -- Range (e.g., "1-5")
        local start_num, end_num = part:match "^(%d+)%-(%d+)$"
        start_num, end_num = tonumber(start_num), tonumber(end_num)
        if start_num and end_num and start_num >= 1 and end_num <= #items and start_num <= end_num then
          for i = start_num, end_num do
            table.insert(selections, i)
          end
        end
      end
    end
  end

  -- Remove duplicates
  local unique_selections = {}
  local seen = {}
  for _, sel in ipairs(selections) do
    if not seen[sel] then
      seen[sel] = true
      table.insert(unique_selections, sel)
    end
  end

  if #unique_selections == 0 then
    vim.notify("No valid selections found", vim.log.levels.WARN, { title = "Language Manager" })
    return
  end

  -- Apply toggles or bulk actions
  local toggled_languages = {}

  if bulk_action == "enable_all" then
    -- Enable all languages
    local all_languages = {}
    for _, lang_info in ipairs(lang_manager.available_languages) do
      table.insert(all_languages, lang_info.name)
    end
    lang_manager.save_enabled_languages(all_languages)
    table.insert(toggled_languages, "All languages enabled")
  elseif bulk_action == "disable_all" then
    -- Disable all languages
    lang_manager.save_enabled_languages {}
    table.insert(toggled_languages, "All languages disabled")
  else
    -- Individual toggles
    for _, idx in ipairs(unique_selections) do
      local item = items[idx]
      local new_state = lang_manager.toggle_language(item.name)
      local action = new_state and "enabled" or "disabled"
      table.insert(toggled_languages, string.format("%s (%s)", item.display, action))
    end
  end

  -- Show results
  local message
  if bulk_action then
    message = table.concat(toggled_languages, "\n")
  else
    message = string.format("Toggled %d language(s):\n%s", #toggled_languages, table.concat(toggled_languages, "\n"))
  end

  vim.notify(message, vim.log.levels.INFO, { title = "Language Manager" })

  -- Ask if user wants to restart Neovim
  vim.schedule(function()
    local restart_choice = vim.fn.confirm(
      "Language configuration updated. Restart Neovim to apply changes?",
      "&Yes\n&No\n&Show restart command",
      1
    )

    if restart_choice == 1 then
      vim.cmd "qa"
    elseif restart_choice == 3 then
      vim.notify("Run ':qa' to restart Neovim", vim.log.levels.INFO)
    end
  end)
end

-- Alternative UI using input for quick search and toggle
function M.quick_toggle()
  require("snacks").input.input({
    prompt = "Toggle language: ",
    completion = function(text)
      local matches = {}
      for _, lang_info in ipairs(lang_manager.available_languages) do
        if
          string.find(string.lower(lang_info.display), string.lower(text))
          or string.find(string.lower(lang_info.name), string.lower(text))
        then
          table.insert(matches, lang_info.name)
        end
      end
      return matches
    end,
  }, function(input)
    if input and input ~= "" then
      -- Find matching language
      local found_lang = nil
      for _, lang_info in ipairs(lang_manager.available_languages) do
        if
          string.lower(lang_info.name) == string.lower(input)
          or string.lower(lang_info.display) == string.lower(input)
        then
          found_lang = lang_info
          break
        end
      end

      if found_lang then
        local new_state = lang_manager.toggle_language(found_lang.name)
        local action = new_state and "enabled" or "disabled"
        vim.notify(
          string.format("Language '%s' %s", found_lang.display, action),
          vim.log.levels.INFO,
          { title = "Language Manager" }
        )
      else
        vim.notify("Language not found: " .. input, vim.log.levels.WARN)
      end
    end
  end)
end

return M
