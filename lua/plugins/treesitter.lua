local parsers = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'javascript', 'vimdoc', 'vim', 'ruby', 'graphql', 'php' }

local select_map = {
  aa = '@parameter.outer',
  ia = '@parameter.inner',
  af = '@function.outer',
  ['if'] = '@function.inner',
  ac = '@class.outer',
  ic = '@class.inner',
}

local move_map = {
  goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
  goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
  goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
  goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
}

local function setup_textobjects()
  require('nvim-treesitter-textobjects').setup {
    select = { lookahead = true },
    move = { set_jumps = true },
  }

  local select = require 'nvim-treesitter-textobjects.select'
  for lhs, query in pairs(select_map) do
    vim.keymap.set({ 'x', 'o' }, lhs, function()
      select.select_textobject(query, 'textobjects')
    end, { desc = 'Select ' .. query })
  end

  local move = require 'nvim-treesitter-textobjects.move'
  for fn, maps in pairs(move_map) do
    for lhs, query in pairs(maps) do
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
        move[fn](query, 'textobjects')
      end, { desc = 'Move ' .. fn .. ' ' .. query })
    end
  end

  local swap = require 'nvim-treesitter-textobjects.swap'
  vim.keymap.set('n', '<leader>xa', function()
    swap.swap_next '@parameter.inner'
  end, { desc = 'Swap parameter with next' })
  vim.keymap.set('n', '<leader>xA', function()
    swap.swap_previous '@parameter.inner'
  end, { desc = 'Swap parameter with previous' })
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  config = function()
    require('nvim-treesitter').install(parsers)
    setup_textobjects()
  end,
}
