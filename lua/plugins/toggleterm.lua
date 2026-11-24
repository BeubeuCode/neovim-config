local lazygit

local function toggle_lazygit()
  lazygit = lazygit or require('toggleterm.terminal').Terminal:new { cmd = 'lazygit', direction = 'float', hidden = true }
  lazygit:toggle()
end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'ToggleTermToggleAll' },
  keys = {
    { '<leader>t', '<cmd>ToggleTerm size=40 dir=. direction=float<cr>', desc = 'Floating [T]erminal' },
    { '<leader>gg', toggle_lazygit, desc = '[G]it [G]ui (lazygit)' },
  },
  opts = {},
}
