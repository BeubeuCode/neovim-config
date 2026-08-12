return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require('null-ls')
    local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })

    -- JS/TS format on demand only (<Leader>f), not on save.
    local skip_format_on_save = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
    }

    -- Prefer the project's own binaries; fall back to PATH.
    local local_bin = { prefer_local = 'node_modules/.bin' }

    null_ls.setup({
      sources = {
        require('none-ls.code_actions.eslint').with(local_bin),
        require('none-ls.formatting.eslint').with(local_bin),
        null_ls.builtins.formatting.prettier.with(vim.tbl_extend('force', local_bin, {
          filetypes = { 'css', 'graphql', 'html', 'json', 'less', 'markdown', 'scss', 'yaml' },
        })),
        -- PHPStan/Larastan: only runs if the project has a phpstan config at its root.
        null_ls.builtins.diagnostics.phpstan.with({
          command = 'vendor/bin/phpstan',
          cwd = function(params) return params.root end,
          runtime_condition = function(params)
            return vim.fn.filereadable(params.root .. '/phpstan.neon') == 1
              or vim.fn.filereadable(params.root .. '/phpstan.neon.dist') == 1
          end,
        }),
      },
      on_attach = function(client, bufnr)
        if not client:supports_method('textDocument/formatting') then
          return
        end

        vim.keymap.set({ 'n', 'x' }, '<Leader>f', function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end, { buffer = bufnr, desc = '[lsp] format' })

        local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
        if skip_format_on_save[filetype] then
          return
        end

        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
          desc = '[lsp] format on save',
        })
      end,
    })
  end,
}
