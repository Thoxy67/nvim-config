local languages = {
  "rust",
  "gleam",
  "v",
  "zig",
  "go",
  "ocaml",
  "clang",
  "cmake",
  "docker",
  "markdown",
  "c3",
  "odin",
  "python",
  "json",
  "yaml",
  "shell",
  "typescript",
  "vue",
  "svelte",
  "qmk",
}

local function toggle_language(lang)
  local file_path = "lua/plugins/init.lua"
  local file = vim.fn.readfile(file_path)
  local pattern = "import%s*=%s*\"plugins/languages/" .. lang .. "\""
  for i, line in ipairs(file) do
    if line:match(pattern) then
      if line:match("^%s*--") then
        -- Remove the comment
        file[i] = line:gsub("^(%s*)--(%s*)", "%1%2")
      else
        -- Add comment
        file[i] = "-- " .. line
      end
      break
    end
  end
  vim.fn.writefile(file, file_path)
end

local function get_language_items()
  local items = {}
  local file = vim.fn.readfile("lua/plugins/init.lua")
  for _, lang in ipairs(languages) do
    local enabled = false
    local pattern = "import%s*=%s*\"plugins/languages/" .. lang .. "\""
    for _, line in ipairs(file) do
      if line:match(pattern) and not line:match("^%s*--") then
        enabled = true
        break
      end
    end
    table.insert(items, {
      text = lang .. (enabled and " (enabled)" or " (disabled)"),
      lang = lang,
      enabled = enabled,
    })
  end
  return items
end

local function toggle_languages()
  local items = get_language_items()
  Snacks.picker({
    source = "Toggle Language Plugins",
    items = items,
    format = "text",
    confirm = function(picker, item)
      if item then
        toggle_language(item.lang)
        vim.notify("Toggled " .. item.lang .. (item.enabled and " off" or " on"))
        picker:close()
        -- Optionally refresh lazy
        vim.cmd("Lazy reload")
      end
    end,
  })
end

return {
  toggle_languages = toggle_languages,
}