return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFindFile' },
  keys = { { '<leader>fb', '<cmd>NvimTreeToggle<cr>', desc = '[F]ile [B]rowser' } },
  opts = {},
}
