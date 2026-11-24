local function builtin(name, opts)
  return function()
    require('telescope.builtin')[name](opts)
  end
end

return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>?', builtin 'oldfiles', desc = '[?] Recently opened files' },
    { '<leader><space>', builtin 'buffers', desc = '[ ] Open buffers' },
    { '<leader>sf', builtin 'find_files', desc = '[S]earch [F]iles' },
    { '<leader>sh', builtin 'help_tags', desc = '[S]earch [H]elp' },
    { '<leader>sw', builtin 'grep_string', desc = '[S]earch current [W]ord' },
    { '<leader>sg', builtin 'live_grep', desc = '[S]earch by [G]rep' },
    { '<leader>sG', builtin('live_grep', { additional_args = { '--fixed-strings' } }), desc = '[S]earch by [G]rep (literal)' },
    { '<leader>sd', builtin 'diagnostics', desc = '[S]earch [D]iagnostics' },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end,
      desc = '[/] Fuzzy search in current buffer',
    },
  },
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        file_ignore_patterns = { 'node_modules' },
        mappings = {
          i = { ['<C-u>'] = false, ['<C-d>'] = false },
        },
      },
    }
    pcall(telescope.load_extension, 'fzf')
  end,
}
