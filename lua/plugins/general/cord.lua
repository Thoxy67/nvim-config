-- cord.lua - Discord Rich Presence
return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    lazy = false,
    enabled = true,
    opts = function()
      return {
        enabled = true,
        log_level = vim.log.levels.OFF,
        editor = {
          client = "nvchad",
          tooltip = "The Superior Text Editor",
          icon = require("cord.api.icon").get "nvchad",
        },
        display = {
          theme = "default",
          flavor = "dark",
          swap_fields = false,
          swap_icons = false,
        },
        timestamp = {
          enabled = true,
          reset_on_idle = false,
          reset_on_change = false,
        },
        idle = {
          enabled = false,
          timeout = 300000,
          show_status = true,
          ignore_focus = true,
          unidle_on_focus = true,
          smart_idle = true,
          details = "Idling",
          state = nil,
          tooltip = "💤",
          icon = nil,
        },
        -- stylua: ignore
        -- text = {
        --   default = nil,
        --   workspace = function(opts) return 'In ' .. opts.workspace end,
        --   viewing = function(opts) return 'Viewing ' .. opts.filename end,
        --   editing = function(opts) return 'Editing ' .. opts.filename end,
        --   file_browser = function(opts) return 'Browsing files in ' .. opts.name end,
        --   plugin_manager = function(opts) return 'Managing plugins in ' .. opts.name end,
        --   lsp = function(opts) return 'Configuring LSP in ' .. opts.name end,
        --   docs = function(opts) return 'Reading ' .. opts.name end,
        --   vcs = function(opts) return 'Committing changes in ' .. opts.name end,
        --   notes = function(opts) return 'Taking notes in ' .. opts.name end,
        --   debug = function(opts) return 'Debugging in ' .. opts.name end,
        --   test = function(opts) return 'Testing in ' .. opts.name end,
        --   diagnostics = function(opts) return 'Fixing problems in ' .. opts.name end,
        --   games = function(opts) return 'Playing ' .. opts.name end,
        --   terminal = function(opts) return 'Running commands in ' .. opts.name end,
        --   dashboard = 'Home',
        -- },
        -- stylua: ignore
        text = {
          default = nil,
          workspace = function() return 'My shitty workspace' end,
          viewing = function() return 'Viewing My shit' end,
          editing = function() return 'Editing My shit' end,
          file_browser = function() return 'Browsing files' end,
          plugin_manager = function() return 'Managing plugins' end,
          lsp = function() return 'Configuring LSP' end,
          docs = function() return 'Reading' end,
          vcs = function() return 'Committing changes' end,
          notes = function() return 'Taking notes' end,
          debug = function() return 'Debugging' end,
          test = function() return 'Testing' end,
          diagnostics = function() return 'Fixing problems' end,
          games = function() return 'Playing' end,
          terminal = function() return 'Running commands' end,
          dashboard = 'Home',
        },
        buttons = {
          {
            label = "View Repository",
            url = function(opts)
              return opts.repo_url
            end,
          },
          {
            label = "View Config",
            url = "https://git.thoxy.xyz/thoxy/nvim-config",
          },
        },
        assets = nil,
        variables = nil,
        hooks = {
          ready = nil,
          shutdown = nil,
          pre_activity = nil,
          post_activity = nil,
          idle_enter = nil,
          idle_leave = nil,
          workspace_change = nil,
        },
        plugins = nil,
        advanced = {
          plugin = {
            autocmds = true,
            cursor_update = "on_hold",
            match_in_mappings = true,
          },
          server = {
            update = "fetch",
            pipe_path = nil,
            executable_path = nil,
            timeout = 300000,
          },
          discord = {
            reconnect = {
              enabled = true,
              interval = 5000,
              initial = true,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("cord").setup(opts)
    end,
  },
}
