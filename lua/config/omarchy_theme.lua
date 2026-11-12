local M = {}

local generated_theme = vim.fn.expand '~/.local/state/omarchy/current/theme/neovim.lua'
local transparency = vim.fn.stdpath 'config' .. '/plugin/after/transparency.lua'

function M.resolve()
  package.loaded['plugins.theme'] = nil
  local ok, specs = pcall(require, 'plugins.theme')
  if not ok or type(specs) ~= 'table' then
    return { 'ellisonleao/gruvbox.nvim', priority = 1000 }, 'gruvbox'
  end

  local theme_spec
  local colorscheme
  for _, spec in ipairs(specs) do
    if type(spec) == 'table' and spec[1] == 'LazyVim/LazyVim' then
      colorscheme = spec.opts and spec.opts.colorscheme or colorscheme
    elseif not theme_spec and type(spec) == 'table' and type(spec[1]) == 'string' then
      theme_spec = vim.deepcopy(spec)
    end
  end

  return theme_spec or { 'ellisonleao/gruvbox.nvim', priority = 1000 }, colorscheme or 'gruvbox'
end

function M.plugin_name(spec)
  if spec.name then
    return spec.name
  end
  return spec[1] and spec[1]:match '([^/]+)$' or nil
end

function M.apply(colorscheme)
  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify(('Could not load Omarchy colorscheme %q from %s: %s'):format(colorscheme, generated_theme, err), vim.log.levels.ERROR)
    return
  end

  if vim.fn.filereadable(transparency) == 1 then
    vim.cmd.source(transparency)
  end
  vim.cmd 'redraw!'
end

return M
