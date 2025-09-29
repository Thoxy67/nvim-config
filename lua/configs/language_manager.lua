local M = {}

-- Cache for enabled languages to avoid repeated file I/O
local _enabled_cache = nil
local _cache_valid = true

-- Available language plugins
M.available_languages = {
  { name = "rust", display = "Rust   ", path = "plugins/languages/rust" },
  { name = "gleam", display = "Gleam   ", path = "plugins/languages/gleam" },
  { name = "v", display = "V   ", path = "plugins/languages/v" },
  { name = "zig", display = "Zig   ", path = "plugins/languages/zig" },
  { name = "go", display = "Go/XGo 󰟓 ", path = "plugins/languages/go" },
  { name = "ocaml", display = "OCaml   ", path = "plugins/languages/ocaml" },
  { name = "clang", display = "C/C++   / ", path = "plugins/languages/clang" },
  { name = "cmake", display = "CMake   ", path = "plugins/languages/cmake" },
  { name = "docker", display = "Docker   ", path = "plugins/languages/docker" },
  { name = "markdown", display = "Markdown   ", path = "plugins/languages/markdown" },
  { name = "c3", display = "C3", path = "plugins/languages/c3" },
  { name = "odin", display = "Odin  󰟢 ", path = "plugins/languages/odin" },
  { name = "python", display = "Python   ", path = "plugins/languages/python" },
  { name = "json", display = "JSON   ", path = "plugins/languages/json" },
  { name = "yaml", display = "YAML   ", path = "plugins/languages/yaml" },
  { name = "toml", display = "TOML   ", path = "plugins/languages/toml" },
  { name = "shell", display = "Shell   ", path = "plugins/languages/shell" },
  { name = "typescript", display = "TypeScript/JavaScript    ", path = "plugins/languages/typescript" },
  { name = "vue", display = "Vue.js   ", path = "plugins/languages/vue" },
  { name = "svelte", display = "Svelte   ", path = "plugins/languages/svelte" },
  { name = "web", display = "Web (html/css/sass/less)     ", path = "plugins/languages/asm" },
  { name = "qmk", display = "QMK  󰌌 ", path = "plugins/languages/qmk" },
  { name = "asm", display = "Assembly (ASM)   ", path = "plugins/languages/asm" },
  { name = "git", display = "Git   ", path = "plugins/languages/git" },
  { name = "eslint", display = "Eslint   ", path = "plugins/languages/eslint" },
  { name = "typst", display = "Typst   ", path = "plugins/languages/typst" },
}

-- Default enabled languages (you can customize this)
M.default_enabled = {
  "rust",
  "go",
  "python",
  "typescript",
  "json",
  "yaml",
  "toml",
  "shell",
  "markdown",
}

-- Configuration file path
M.config_file = vim.fn.stdpath "config" .. "/lua/configs/enabled_languages.lua"

-- Load enabled languages from config file with caching
function M.load_enabled_languages()
  if _enabled_cache and _cache_valid then
    return _enabled_cache
  end

  local ok, enabled = pcall(dofile, M.config_file)
  if ok and type(enabled) == "table" then
    _enabled_cache = enabled
    _cache_valid = true
    return enabled
  end

  _enabled_cache = M.default_enabled
  _cache_valid = true
  return M.default_enabled
end

-- Invalidate cache when languages are saved
local function invalidate_cache()
  _cache_valid = false
  _enabled_cache = nil
end

-- Save enabled languages to config file
function M.save_enabled_languages(enabled)
  invalidate_cache()

  local file = io.open(M.config_file, "w")
  if file then
    -- Build content in memory first to reduce file I/O
    local content = {
      "-- Auto-generated language configuration\n",
      "-- Modify through the language manager UI\n",
      "return {\n",
    }

    for _, lang in ipairs(enabled) do
      table.insert(content, string.format('  "%s",\n', lang))
    end
    table.insert(content, "}\n")

    file:write(table.concat(content))
    file:close()
  end
end

-- Check if a language is enabled (optimized with lookup table)
function M.is_enabled(lang_name)
  local enabled = M.load_enabled_languages()

  -- Convert to lookup table for O(1) access if multiple checks expected
  if #enabled > 5 then
    local lookup = {}
    for _, enabled_lang in ipairs(enabled) do
      lookup[enabled_lang] = true
    end
    return lookup[lang_name] or false
  end

  -- For small lists, linear search is faster
  for _, enabled_lang in ipairs(enabled) do
    if enabled_lang == lang_name then
      return true
    end
  end
  return false
end

-- Toggle a language on/off (optimized)
function M.toggle_language(lang_name)
  local enabled = M.load_enabled_languages()
  local new_enabled = {}
  local found = false

  -- Pre-allocate table size for better performance
  table.move(enabled, 1, #enabled, 1, new_enabled)

  for i = 1, #new_enabled do
    if new_enabled[i] == lang_name then
      table.remove(new_enabled, i)
      found = true
      break
    end
  end

  if not found then
    table.insert(new_enabled, lang_name)
  end

  M.save_enabled_languages(new_enabled)
  return not found -- return new state
end

-- Get dynamic language imports for lazy.nvim
function M.get_language_imports()
  local enabled = M.load_enabled_languages()
  local imports = {}

  for _, lang_name in ipairs(enabled) do
    for _, lang_info in ipairs(M.available_languages) do
      if lang_info.name == lang_name then
        table.insert(imports, { import = lang_info.path })
        break
      end
    end
  end

  return imports
end

return M
