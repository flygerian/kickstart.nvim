return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      explorer = {
        enabled = true,
      },
      picker = {
        sources = {
          explorer = {
            enabled = true,
          },
        },
      },
    },
    keys = {
      {
        '\\',
        function()
          Snacks.explorer()
        end,
        desc = 'Toggle explorer',
      },
    },
  },
}
