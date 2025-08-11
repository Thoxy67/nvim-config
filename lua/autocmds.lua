require "nvchad.autocmds"

-- Auto Commands
local autocmd = vim.api.nvim_create_autocmd

-- User Command
local usercmd = vim.api.nvim_create_user_command

usercmd("NvConfig", function()
  local config_path = vim.fn.stdpath "config"

  vim.cmd("cd " .. config_path)
  vim.cmd "e $MYVIMRC"

  vim.notify("📁 Open Config directory: " .. config_path, vim.log.levels.INFO, {
    title = "Directory Changed",
  })
end, {
  desc = "Open NvChad config directory",
})

usercmd("NvUpdate", function()
  vim.notify("🔄 Starting update process...", vim.log.levels.INFO, {
    title = "NvUpdate",
  })

  -- Run commands in sequence
  vim.cmd "TSUpdate"
  vim.cmd "MasonUpdate"
  vim.cmd "Lazy sync"
  vim.cmd "Lazy update"

  vim.notify("✅ Update process completed!", vim.log.levels.INFO, {
    title = "NvUpdate",
  })
end, {
  desc = "Update TreeSitter parsers, Lazy plugins, Mason modules, and install missing parsers (parallel)",
})

usercmd("Explore", function(opts)
  local path = opts.args ~= "" and opts.args or "."
  local cmd

  if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
    cmd = "explorer " .. path
  else
    cmd = "open " .. path
  end

  vim.fn.system(cmd)
end, {
  nargs = "?",
  complete = "dir",
  desc = "Open system file browser at specified directory or current directory",
})

usercmd("DapUIToggle", function()
  require("dapui").toggle()
end, { desc = "Open DapUI" })

usercmd("FormatFile", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format files via conform" })
