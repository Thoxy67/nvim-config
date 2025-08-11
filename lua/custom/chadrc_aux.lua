local M = {}

M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.git_custom = function()
  local run = "%@RunNeogit@"
  local stop = "%X"

  local bufnr = M.stbufnr()
  if not vim.b[bufnr].gitsigns_head or vim.b[bufnr].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[bufnr].gitsigns_status_dict
  local clear_hl = "%#StText#"
  local add_hl = "%#St_Lsp#"
  local changed_hl = "%#StText#"
  local rm_hl = "%#St_LspError#"
  local branch_hl = "%#St_GitBranch#"

  local added = (git_status.added and git_status.added ~= 0) and (add_hl .. "  " .. clear_hl .. git_status.added)
    or ""
  local changed = (git_status.changed and git_status.changed ~= 0)
      and (changed_hl .. "  " .. clear_hl .. git_status.changed)
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0)
      and (rm_hl .. "  " .. clear_hl .. git_status.removed)
    or ""
  local branch_name = branch_hl .. " " .. clear_hl .. git_status.head

  return run .. " " .. branch_name .. " " .. added .. changed .. removed .. stop
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

return M
