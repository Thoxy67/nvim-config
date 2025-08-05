require "nvchad.autocmds"

-- Auto Commands
local autocmd = vim.api.nvim_create_autocmd

-- User Command
local usercmd = vim.api.nvim_create_user_command

usercmd('Config', function()
    local config_path = vim.fn.stdpath('config')
    local init_path = config_path .. '/init.lua'

    vim.cmd('cd ' .. config_path)

    vim.notify('📁 Open Config directory: ' .. config_path, vim.log.levels.INFO, {
        title = 'Directory Changed'
    })
end, {
    desc = 'Change to NvChad config directory'
})


usercmd('NvUpdate', function()
    vim.notify('🔄 Starting update process...', vim.log.levels.INFO, {
        title = 'NvUpdate'
    })

    -- Run commands in sequence
    vim.cmd('TSUpdate')
    vim.cmd('Lazy update')
    vim.cmd('MasonUpdate')
    vim.cmd('MasonInstallAll')

    vim.notify('✅ Update process completed!', vim.log.levels.INFO, {
        title = 'NvUpdate'
    })
end, {
    desc = "Update TreeSitter parsers, Lazy plugins, Mason modules, and install missing parsers (parallel)"
})
