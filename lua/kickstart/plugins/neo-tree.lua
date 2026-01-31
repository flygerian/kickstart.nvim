-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {},
  opts = {
    enable_git_status = false,
    enable_diagnostics = false,
    close_if_last_window = true,
    filesystem = {
      scan_mode = 'shallow',
      async_directory_scan = 'always',
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          'node_modules',
          '.git',
          'target',
          'build',
          'dist',
          '.vscode',
          '.husky',
          '.cursor',
          '.claude',
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true, -- Key: don't collapse dirs you've navigated to
      },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
    -- Performance optimization
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = '',
        expander_expanded = '',
      },
    },
  },
}
