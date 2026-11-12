local omarchy = require 'config.omarchy_theme'
local theme_spec, colorscheme = omarchy.resolve()
local original_init = theme_spec.init

theme_spec.lazy = false
theme_spec.priority = theme_spec.priority or 1000
theme_spec.init = function(plugin)
  if original_init then
    original_init(plugin)
  end

  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('kickstart-omarchy-theme', { clear = true }),
    once = true,
    callback = function()
      omarchy.apply(colorscheme)
    end,
  })
end

return theme_spec
