local function gitsigns_on_attach(bufnr)
  local gs = require 'gitsigns'
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map('n', ']c', function()
    gs.nav_hunk 'next'
  end, 'Next hunk')
  map('n', '[c', function()
    gs.nav_hunk 'prev'
  end, 'Previous hunk')
  map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'git [S]tage hunk')
  map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'git [R]eset hunk')
  map('n', '<leader>hp', gs.preview_hunk, 'git [P]review hunk')
  map('n', '<leader>hb', function()
    gs.blame_line { full = true }
  end, 'git [B]lame line')
  map('n', '<leader>hd', gs.diffthis, 'git [D]iff this')
end

return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'f-person/git-blame.nvim',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = gitsigns_on_attach,
    },
  },
}
