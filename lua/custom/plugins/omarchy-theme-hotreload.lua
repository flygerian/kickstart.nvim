return {
  {
    name = 'theme-hotreload',
    dir = vim.fn.stdpath 'config',
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyReload',
        callback = function()
          package.loaded['plugins.theme'] = nil
          package.loaded['kickstart.plugins.theme'] = nil

          vim.schedule(function()
            local omarchy = require 'config.omarchy_theme'
            local theme_spec, colorscheme = omarchy.resolve()
            local plugin_name = omarchy.plugin_name(theme_spec)

            vim.cmd 'highlight clear'
            if vim.fn.exists 'syntax_on' then
              vim.cmd 'syntax reset'
            end
            vim.o.background = 'dark'

            local plugin = plugin_name and require('lazy.core.config').plugins[plugin_name]
            if plugin and plugin._.loaded then
              local plugin_dir = plugin.dir .. '/lua'
              require('lazy.core.util').walkmods(plugin_dir, function(module)
                package.loaded[module] = nil
                package.preload[module] = nil
              end)
              require('lazy.core.loader').reload(plugin)
            else
              require('lazy.core.loader').colorscheme(colorscheme)
            end

            vim.defer_fn(function()
              omarchy.apply(colorscheme)
            end, 10)
          end)
        end,
      })
    end,
  },
}
