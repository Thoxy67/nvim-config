vim.cmd [[
  function! RunNeogit(...)
    lua require("neogit").open()
  endfunction
]]

vim.cmd [[
  function! LspHealthCheck(...)
    LspInfo
  endfunction
]]

vim.cmd [[
  function! RunHarpoon(...)
    RunHarpoon
  endfunction
]]

vim.cmd [[
  function! OpenDir(...)
    Explore .
  endfunction
]]

vim.cmd [[
  function! OilDirCWD(...)
    Oil ./
  endfunction
]]

vim.cmd [[
  function! Trouble(...)
    Trouble
  endfunction
]]

vim.cmd [[
  function! OverseerToggle(...)
    OverseerToggle
  endfunction
]]
