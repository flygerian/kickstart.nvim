-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Function to get project name from current directory
      local function get_project_name()
        local cwd = vim.fn.getcwd()
        local project_name = vim.fn.fnamemodify(cwd, ':t')

        project_name = project_name:gsub('[_-]', ' ')
        return project_name
      end

      -- Function to generate ASCII art from text
      local function generate_header()
        local project_name = get_project_name()
        local handle = io.popen("figlet -f 'ANSI Shadow' '" .. project_name .. "'")
        local result = handle:read '*a'
        handle:close()

        local lines = {}
        for line in result:gmatch '[^\r\n]+' do
          table.insert(lines, line)
        end

        return lines
      end

      dashboard.section.header.val = generate_header()

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':lua Snacks.picker.files() <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '  Recent files', ':lua Snacks.picker.recent() <CR>'),
        dashboard.button('s', '  Resume', ':lua Snacks.picker.resume() <CR>'),
        dashboard.button('g', '  Find text', ':lua Snacks.picker.grep() <CR>'),
        dashboard.button('c', '  Config', ':e $MYVIMRC <CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      local opts = dashboard.opts

      opts.layout = {
        { type = 'padding', val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
        dashboard.section.header,
        { type = 'padding', val = 5 },
        dashboard.section.buttons,
        { type = 'padding', val = 3 },
        dashboard.section.footer,
      }

      dashboard.section.header.opts = {
        position = 'center',
        hl = 'Type',
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd [[
        autocmd FileType alpha setlocal nofoldenable
        autocmd FileType alpha setlocal nowrap
      ]]
    end,
  },
}
