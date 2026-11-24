local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map('n', 'n', 'nzzzv', { desc = 'Next search result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

map('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<C-n>', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map('n', '<C-p>', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })

map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-v><Esc>', '<Esc>', { desc = 'Send Esc to terminal' })

map('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Previous diagnostic' })
map('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Floating diagnostic' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })

local function yank_path(with_line)
  local path = vim.fn.fnamemodify(vim.fn.expand '%', ':.')
  if with_line then
    path = path .. ':' .. vim.fn.line '.'
  end
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end

map('n', '<leader>yp', function()
  yank_path(false)
end, { desc = '[Y]ank relative [P]ath' })
map('n', '<leader>yl', function()
  yank_path(true)
end, { desc = '[Y]ank relative path with [L]ine' })
