local function on_attach(event)
  local builtin = require 'telescope.builtin'
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
  map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  map('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  map('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
  map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist folders')

  vim.api.nvim_buf_create_user_command(event.buf, 'Format', function()
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Pest binds test closures to an anonymous TestCase subclass, so intelephense
-- can't see dynamic `$this->foo` properties set in beforeEach() and flags them
-- as undefined (P1014). Drop just that code, and only under tests/.
local function filter_pest_diagnostics(err, result, ctx, config)
  if result and result.diagnostics and result.uri:match '/tests/' then
    result.diagnostics = vim.tbl_filter(function(d)
      return d.code ~= 'P1014'
    end, result.diagnostics)
  end
  vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = on_attach,
    })

    vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { globals = { 'vim' } },
        },
      },
    })
    vim.lsp.config('intelephense', {
      handlers = { ['textDocument/publishDiagnostics'] = filter_pest_diagnostics },
    })

    require('mason').setup()
    require('mason-lspconfig').setup { ensure_installed = { 'ts_ls', 'lua_ls', 'ruby_lsp', 'rust_analyzer', 'gopls' } }
  end,
}
