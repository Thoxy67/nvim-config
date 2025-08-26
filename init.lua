-- Leader key must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Base46 cache for themes
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin configurations
local lazy_config = require "configs.lazy"

-- Setup plugins
require("lazy").setup({
  -- NvChad base
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  -- User plugins
  { import = "plugins" },
}, lazy_config)

-- Load themes
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "devicons")
dofile(vim.g.base46_cache .. "blankline")

-- Load configurations
require "options"
require "autocmds"
require "custom.vimcmd"

-- Load mappings after UI is ready
vim.schedule(function()
  require "mappings"
end)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
