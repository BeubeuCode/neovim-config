return {
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    priority = 999,
    config = function()
      vim.cmd 'TransparentEnable'
    end,
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = { { '<leader>z', '<cmd>ColorizerToggle<cr>', desc = 'Toggle colorizer' } },
    config = function()
      require('colorizer').setup()
    end,
  },
  { 'folke/trouble.nvim', cmd = 'Trouble', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
}
