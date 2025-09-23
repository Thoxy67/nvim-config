local M = {}

-- Available language plugins
M.available_languages = {
  { name = "rust", display = "Rust", path = "plugins/languages/rust" },
  { name = "gleam", display = "Gleam", path = "plugins/languages/gleam" },
  { name = "v", display = "V", path = "plugins/languages/v" },
  { name = "zig", display = "Zig", path = "plugins/languages/zig" },
  { name = "go", display = "Go", path = "plugins/languages/go" },
  { name = "ocaml", display = "OCaml", path = "plugins/languages/ocaml" },
  { name = "clang", display = "C/C++", path = "plugins/languages/clang" },
  { name = "cmake", display = "CMake", path = "plugins/languages/cmake" },
  { name = "docker", display = "Docker", path = "plugins/languages/docker" },
  { name = "markdown", display = "Markdown", path = "plugins/languages/markdown" },
  { name = "c3", display = "C3", path = "plugins/languages/c3" },
  { name = "odin", display = "Odin", path = "plugins/languages/odin" },
  { name = "python", display = "Python", path = "plugins/languages/python" },
  { name = "json", display = "JSON", path = "plugins/languages/json" },
  { name = "yaml", display = "YAML", path = "plugins/languages/yaml" },
  { name = "toml", display = "TOML", path = "plugins/languages/toml" },
  { name = "shell", display = "Shell", path = "plugins/languages/shell" },
  { name = "typescript", display = "TypeScript/JavaScript", path = "plugins/languages/typescript" },
  { name = "vue", display = "Vue.js", path = "plugins/languages/vue" },
  { name = "svelte", display = "Svelte", path = "plugins/languages/svelte" },
  { name = "qmk", display = "QMK", path = "plugins/languages/qmk" },
  { name = "asm", display = "Assembly (ASM)", path = "plugins/languages/asm" },
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

-- Load enabled languages from config file
function M.load_enabled_languages()
  local ok, enabled = pcall(dofile, M.config_file)
  if ok and type(enabled) == "table" then
    return enabled
  end
  return M.default_enabled
end

-- Save enabled languages to config file
function M.save_enabled_languages(enabled)
  local file = io.open(M.config_file, "w")
  if file then
    file:write "-- Auto-generated language configuration\n"
    file:write "-- Modify through the language manager UI\n"
    file:write "return {\n"
    for _, lang in ipairs(enabled) do
      file:write(string.format('  "%s",\n', lang))
    end
    file:write "}\n"
    file:close()
  end
end

-- Check if a language is enabled
function M.is_enabled(lang_name)
  local enabled = M.load_enabled_languages()
  for _, enabled_lang in ipairs(enabled) do
    if enabled_lang == lang_name then
      return true
    end
  end
  return false
end

-- Toggle a language on/off
function M.toggle_language(lang_name)
  local enabled = M.load_enabled_languages()
  local found = false
  local new_enabled = {}

  for _, enabled_lang in ipairs(enabled) do
    if enabled_lang == lang_name then
      found = true
      -- Don't add it to new_enabled (remove it)
    else
      table.insert(new_enabled, enabled_lang)
    end
  end

  if not found then
    -- Add it
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
