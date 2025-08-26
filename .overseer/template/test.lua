return {
  name = "test task",
  builder = function()
    return {
      cmd = { "echo" },
      args = { "Testing overseer!" },
    }
  end,
  condition = {
    filetype = { "lua" },
  },
}
