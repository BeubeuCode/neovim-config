return  {
    'MunifTanjim/prettier.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function ()
      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre" -- or "BufWritePost"
      local async = event == "BufWritePost"

      null_ls.setup({
        on_attach = function(client, bufnr)
          local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
          local skip_format_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
          local should_format = not vim.tbl_contains(skip_format_filetypes, filetype)

          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save (skip for JS/TS files)
            if should_format then
              vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
              vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, async = async })
                end,
                desc = "[lsp] format on save",
              })
            end
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
        end,
        sources = {null_ls.builtins.code_actions.eslint, null_ls.builtins.formatting.eslint},
      })

      local prettier = require("prettier")

      prettier.setup({
        bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
        filetypes = {
          "css",
          "graphql",
          "html",
          "json",
          "less",
          "markdown",
          "scss",
          "yaml",
        },
      })
    end
  }

