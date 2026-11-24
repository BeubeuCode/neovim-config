local function run_in_split(cmd)
  vim.cmd 'split'
  vim.cmd('terminal ' .. cmd)
end

local function current_file()
  return vim.fn.expand '%'
end

local function current_line()
  return current_file() .. ':' .. vim.fn.line '.'
end

vim.keymap.set('n', '<leader>rf', function()
  run_in_split('bundle exec rspec ' .. current_file())
end, { desc = '[R]spec [F]ile' })

vim.keymap.set('n', '<leader>rl', function()
  run_in_split('bundle exec rspec ' .. current_line())
end, { desc = '[R]spec [L]ine' })

vim.keymap.set('n', '<leader>rp', function()
  run_in_split('php artisan test ' .. current_file())
end, { desc = '[R]un [P]est file' })
