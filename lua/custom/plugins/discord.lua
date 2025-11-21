local git_branch = vim.fn.system('git branch --show-current'):gsub('\n', '')
return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    enabled = true,
    log_level = vim.log.levels.OFF,
    editor = {
      client = 'neovim',
      tooltip = 'The Superior Text Editor',
      icon = nil,
    },
    display = {
      theme = 'default',
      flavor = 'dark',
      view = 'full',
      swap_fields = false,
      swap_icons = false,
    },
    timestamp = {
      enabled = true,
      reset_on_idle = false,
      reset_on_change = false,
      shared = false,
    },
    idle = {
      enabled = true,
      timeout = 300000,
      show_status = true,
      ignore_focus = true,
      unidle_on_focus = true,
      smart_idle = true,
      details = 'Idling',
      state = nil,
      tooltip = '💤',
      icon = nil,
    },
    text = {
      default = nil,
      workspace = function(opts)
        if opts.workspace == "cauman" then
            return 'In home'
        else
            return 'In ' .. opts.workspace
        end
      end,
      viewing = function(opts)
        return 'Viewing ' .. opts.filename
      end,
      editing = function(opts)
        return string.format('Editing %s - %s:%s', opts.filename, opts.cursor_line, opts.cursor_char)
      end,
      file_browser = function(opts)
        if opts.name == 'cauman' then
          return 'Browsing files in home'
        else
          return 'Browsing files in ' .. opts.name
        end
      end,
      plugin_manager = function(opts)
        return 'Managing plugins in ' .. opts.name
      end,
      lsp = function(opts)
        return 'Configuring LSP in ' .. opts.name
      end,
      docs = function(opts)
        return 'Reading ' .. opts.name
      end,
      vcs = function(opts)
        return 'Committing changes in ' .. opts.name
      end,
      notes = function(opts)
        return 'Taking notes in ' .. opts.name
      end,
      debug = function(opts)
        return 'Debugging in ' .. opts.name
      end,
      test = function(opts)
        return 'Testing in ' .. opts.name
      end,
      diagnostics = function(opts)
        return 'Fixing problems in ' .. opts.name
      end,
      games = function(opts)
        return 'Playing ' .. opts.name
      end,
      terminal = function(opts)
        return 'Running commands in ' .. opts.name
      end,
      dashboard = 'Home',
    },
    buttons = nil,
    assets = nil,
    variables = {
      git_status = function(opts)
        return git_branch
      end,
    },
    hooks = {
      ready = nil,
      shutdown = nil,
      pre_activity = nil,
      post_activity = nil,
      idle_enter = nil,
      idle_leave = nil,
      workspace_change = function(opts)
        git_branch = vim.fn.system('git branch --show-current'):gsub('\n', '')
      end,
      buf_enter = nil,
    },
    plugins = nil,
    advanced = {
      plugin = {
        autocmds = true,
        cursor_update = 'on_hold',
        match_in_mappings = true,
      },
      server = {
        update = 'fetch',
        pipe_path = nil,
        executable_path = nil,
        timeout = 300000,
      },
      discord = {
        pipe_paths = nil,
        reconnect = {
          enabled = false,
          interval = 5000,
          initial = true,
        },
      },
      workspace = {
        root_markers = {
          '.git',
          '.hg',
          '.svn',
        },
        limit_to_cwd = false,
      },
    },
  },
}
