local M = {}
local lang_manager = require "configs.language_manager"

-- Cache for highlight groups to avoid repeated setup
local highlights_setup = false

-- Shared menu sections to avoid duplication
local function get_menu_sections()
  return {
    "────────────────────────────────────────────────────────────────────────────────",
    "󰔡  Direct Language Actions (cursor on language line):",
    "• <leader> - Toggle the language on current line (enable ↔ disable)",
    "• e - Enable the language on current line (if not already enabled)",
    "• x - Disable the language on current line (if not already disabled)",
    "• Cancel: Press <Esc> or leave empty",
    "",
    "  Navigation:",
    "• Use j/k or ↑/↓ to navigate • Ctrl+d/u or PgDn/PgUp to scroll",
    "• gg/G or Home/End to go to top/bottom • q or Esc to close",
    "• Press Enter to start input prompt",
    "",
    "  Input prompt Options:",
    "• Single: Select number (e.g., '3')",
    "• Multiple: Space-separated (e.g., '1 3 5') or comma-separated (e.g., '1,3,5')",
    "• Range: Use hyphen (e.g., '1-5' or '2-4')",
    "• All: Type 'all' to enable all languages",
    "• None: Type 'none' to disable all languages",
    "• Cancel: Press <Esc> or leave empty",
  }
end

-- Create the language toggle UI with multi-selection support
function M.show_language_manager()
  local lang_count = #lang_manager.available_languages

  -- Pre-allocate tables for better performance
  local items = {}
  local display_items = {}

  -- Batch enabled language checks for better performance
  local enabled_languages = lang_manager.load_enabled_languages()
  local enabled_lookup = {}
  for _, lang in ipairs(enabled_languages) do
    enabled_lookup[lang] = true
  end

  for i = 1, lang_count do
    local lang_info = lang_manager.available_languages[i]
    local is_enabled = enabled_lookup[lang_info.name] or false
    local status = is_enabled and "✓" or "✗"

    items[i] = {
      index = i,
      name = lang_info.name,
      display = lang_info.display,
      path = lang_info.path,
      enabled = is_enabled,
    }

    display_items[i] = string.format("%2d. %s %s", i, status, lang_info.display)
  end

  -- Create custom highlight groups (only once)
  local function setup_highlights()
    if highlights_setup then
      return
    end
    vim.api.nvim_set_hl(0, "LanguageManagerTitle", { fg = "#7dcfff", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerEnabled", { fg = "#9ece6a", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerDisabled", { fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "LanguageManagerNumber", { fg = "#bb9af7" })
    vim.api.nvim_set_hl(0, "LanguageManagerOption", { fg = "#e0af68" })
    vim.api.nvim_set_hl(0, "LanguageManagerBorder", { fg = "#7aa2f7" })
    highlights_setup = true
  end

  setup_highlights()

  -- Create a floating window with the menu
  local menu_lines = { "  Select the language to enable or disable :", "" }
  for i = 1, #display_items do
    menu_lines[#menu_lines + 1] = display_items[i]
  end
  -- Add shared menu sections
  local sections = get_menu_sections()
  for i = 1, #sections do
    menu_lines[#menu_lines + 1] = sections[i]
  end

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, menu_lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  -- Calculate window size with scrollable constraints
  local width = math.min(vim.o.columns - 10, 100) -- max width of 100
  local max_height = math.floor(vim.o.lines * 0.8) -- 80% of screen height
  local height = math.min(#menu_lines + 2, max_height)
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

  local win = vim.api.nvim_open_win(buf, true, opts) -- focus the window for scrolling

  -- Add colorful highlighting
  vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:LanguageManagerBorder", { win = win })

  -- Set window options for scrolling
  vim.api.nvim_set_option_value("wrap", false, { win = win })
  vim.api.nvim_set_option_value("cursorline", true, { win = win })

  -- Track if any changes were made during this session
  local changes_made = false

  -- Add key mappings for navigation and scrolling
  local function setup_keymaps()
    local keymap_opts = { buffer = buf, nowait = true, silent = true }

    -- Navigation keys
    vim.keymap.set("n", "j", "j", keymap_opts)
    vim.keymap.set("n", "k", "k", keymap_opts)
    vim.keymap.set("n", "<Down>", "j", keymap_opts)
    vim.keymap.set("n", "<Up>", "k", keymap_opts)

    -- Page scrolling
    vim.keymap.set("n", "<C-d>", "<C-d>", keymap_opts)
    vim.keymap.set("n", "<C-u>", "<C-u>", keymap_opts)
    vim.keymap.set("n", "<PageDown>", "<C-d>", keymap_opts)
    vim.keymap.set("n", "<PageUp>", "<C-u>", keymap_opts)

    -- Go to top/bottom
    vim.keymap.set("n", "gg", "gg", keymap_opts)
    vim.keymap.set("n", "G", "G", keymap_opts)
    vim.keymap.set("n", "<Home>", "gg", keymap_opts)
    vim.keymap.set("n", "<End>", "G", keymap_opts)

    -- Close window with reload prompt if changes were made
    local function close_with_prompt()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end

      if changes_made then
        vim.schedule(function()
          local restart_choice = vim.fn.confirm(
            "Language configuration was updated. Restart Neovim to apply changes?",
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
    end

    vim.keymap.set("n", "q", close_with_prompt, keymap_opts)
    vim.keymap.set("n", "<Esc>", close_with_prompt, keymap_opts)

    -- Enter to trigger input prompt
    vim.keymap.set("n", "<CR>", function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      vim.schedule(function()
        vim.ui.input({
          prompt = "Select languages to toggle: ",
        }, function(input)
          if input and input ~= "" then
            M.process_multi_selection(input, items)
            changes_made = true
          end
        end)
      end)
    end, keymap_opts)

    -- Direct language actions on current line
    local function get_current_language()
      local cursor_line = vim.api.nvim_win_get_cursor(win)[1]
      -- Language items start at line 3 (after title and empty line)
      local lang_index = cursor_line - 2
      if lang_index >= 1 and lang_index <= #items then
        return items[lang_index]
      end
      return nil
    end

    local function refresh_window_content()
      -- Update the display items with current states
      local updated_display_items = {}
      local enabled_languages = lang_manager.load_enabled_languages()
      local enabled_lookup = {}
      for _, lang in ipairs(enabled_languages) do
        enabled_lookup[lang] = true
      end

      for i = 1, #items do
        local lang_info = items[i]
        local is_enabled = enabled_lookup[lang_info.name] or false
        local status = is_enabled and "✓" or "✗"
        items[i].enabled = is_enabled
        updated_display_items[i] = string.format("%2d. %s %s", i, status, lang_info.display)
      end

      -- Update the menu lines
      local updated_menu_lines = { "  Select the language to enable or disable :", "" }
      for i = 1, #updated_display_items do
        updated_menu_lines[#updated_menu_lines + 1] = updated_display_items[i]
      end

      -- Add the rest of the content (direct actions, navigation)
      -- Add shared menu sections
      local sections = get_menu_sections()
      for i = 1, #sections do
        updated_menu_lines[#updated_menu_lines + 1] = sections[i]
      end

      -- Update buffer content
      vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, updated_menu_lines)
      vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

      -- Reapply syntax highlighting
      local ns_id = vim.api.nvim_create_namespace "LanguageManager"

      -- Clear existing highlights
      vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

      -- Highlight title
      vim.hl.range(buf, ns_id, "LanguageManagerTitle", { 0, 0 }, { 0, -1 })

      -- Highlight language entries
      for i = 1, #items do
        local line_idx = i + 1 -- +1 because of title and empty line
        local item = items[i]
        local status_symbol = item.enabled and "✓" or "✗"
        local hl_group = item.enabled and "LanguageManagerEnabled" or "LanguageManagerDisabled"

        -- Highlight the number
        vim.hl.range(buf, ns_id, "LanguageManagerNumber", { line_idx, 0 }, { line_idx, 3 })

        -- Highlight the status symbol
        local display_line = updated_display_items[i]
        local status_start = string.find(display_line, status_symbol)
        if status_start then
          vim.hl.range(buf, ns_id, hl_group, { line_idx, status_start - 1 }, { line_idx, status_start })
        end
      end

      -- Highlight section headers specifically
      local options_start = #items + 3 -- +3 for title, empty line, and separator line

      -- Highlight "Direct Language Actions" header (line options_start + 1)
      vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start, 0 }, { options_start, -1 })

      -- Highlight "Navigation" header (around line options_start + 8)
      vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start + 6, 0 }, { options_start + 6, -1 })

      -- Highlight "Input prompt Options" header (around line options_start + 12)
      vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start + 11, 0 }, { options_start + 11, -1 })

      -- Highlight each option line with bullet points
      for i = 1, 16 do -- Updated count for all sections
        local line_num = options_start + i
        if line_num < #updated_menu_lines then
          local line_content = updated_menu_lines[line_num + 1] or "" -- +1 for 0-based indexing
          if line_content:match "^•" then
            vim.hl.range(buf, ns_id, "LanguageManagerOption", { line_num, 0 }, { line_num, 1 })
          end
        end
      end
    end

    vim.keymap.set("n", "<leader>", function()
      local lang = get_current_language()
      if lang then
        local new_state = lang_manager.toggle_language(lang.name)
        local action = new_state and "enabled" or "disabled"
        vim.notify(string.format("Language '%s' %s", lang.display, action), vim.log.levels.INFO)
        changes_made = true
        refresh_window_content()
      else
        vim.notify("No language selected", vim.log.levels.WARN)
      end
    end, keymap_opts)

    -- Enable language on current line
    vim.keymap.set("n", "e", function()
      local lang = get_current_language()
      if lang then
        if not lang.enabled then
          lang_manager.toggle_language(lang.name)
          vim.notify(string.format("Language '%s' enabled", lang.display), vim.log.levels.INFO)
          changes_made = true
          refresh_window_content()
        else
          vim.notify(string.format("Language '%s' already enabled", lang.display), vim.log.levels.INFO)
        end
      else
        vim.notify("No language selected", vim.log.levels.WARN)
      end
    end, keymap_opts)

    -- Disable language on current line
    vim.keymap.set("n", "x", function()
      local lang = get_current_language()
      if lang then
        if lang.enabled then
          lang_manager.toggle_language(lang.name)
          vim.notify(string.format("Language '%s' disabled", lang.display), vim.log.levels.INFO)
          changes_made = true
          refresh_window_content()
        else
          vim.notify(string.format("Language '%s' already disabled", lang.display), vim.log.levels.INFO)
        end
      else
        vim.notify("No language selected", vim.log.levels.WARN)
      end
    end, keymap_opts)
  end

  setup_keymaps()

  -- Set cursor to the first language item (line 3, after title and empty line)
  vim.api.nvim_win_set_cursor(win, { 3, 0 })

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

  -- Highlight section headers specifically
  local options_start = #items + 3 -- +3 for title, empty line, and separator line

  -- Highlight "Direct Language Actions" header (line options_start + 1)
  vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start, 0 }, { options_start, -1 })

  -- Highlight "Navigation" header (around line options_start + 8)
  vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start + 6, 0 }, { options_start + 6, -1 })

  -- Highlight "Input prompt Options" header (around line options_start + 12)
  vim.hl.range(buf, ns_id, "LanguageManagerOption", { options_start + 11, 0 }, { options_start + 11, -1 })

  -- Highlight each option line with bullet points
  for i = 1, 16 do -- Updated count for all sections
    local line_num = options_start + i
    if line_num < #menu_lines then
      local line_content = menu_lines[line_num + 1] or "" -- +1 for 0-based indexing
      if line_content:match "^•" then
        vim.hl.range(buf, ns_id, "LanguageManagerOption", { line_num, 0 }, { line_num, 1 })
      end
    end
  end

  -- Window is now scrollable and interactive - no automatic input prompt
end

-- Process multi-selection input (optimized)
function M.process_multi_selection(input, items)
  local selections = {}
  local bulk_action = nil
  local items_count = #items

  -- Handle bulk commands (case-insensitive)
  local lower_input = input:lower()
  if lower_input == "all" then
    bulk_action = "enable_all"
    for i = 1, items_count do
      selections[i] = i
    end
  elseif lower_input == "none" then
    bulk_action = "disable_all"
    for i = 1, items_count do
      selections[i] = i
    end
  else
    -- Parse input for numbers, ranges, and separators (optimized)
    local cleaned_input = input:gsub("[%s,]+", " ")

    for part in cleaned_input:gmatch "%S+" do
      local single_num = part:match "^(%d+)$"
      if single_num then
        local num = tonumber(single_num)
        if num and num >= 1 and num <= items_count then
          selections[#selections + 1] = num
        end
      else
        local start_num, end_num = part:match "^(%d+)%-(%d+)$"
        if start_num and end_num then
          start_num, end_num = tonumber(start_num), tonumber(end_num)
          if start_num and end_num and start_num >= 1 and end_num <= items_count and start_num <= end_num then
            for i = start_num, end_num do
              selections[#selections + 1] = i
            end
          end
        end
      end
    end
  end

  -- Remove duplicates (optimized)
  local unique_selections = {}
  local seen = {}
  for i = 1, #selections do
    local sel = selections[i]
    if not seen[sel] then
      seen[sel] = true
      unique_selections[#unique_selections + 1] = sel
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

return M
