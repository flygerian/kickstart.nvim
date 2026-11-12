return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    opts = {
      -- The main Kickstart config owns gopls and nvim-dap.
      lsp_cfg = false,
      dap_debug = false,
    },
  },
}
