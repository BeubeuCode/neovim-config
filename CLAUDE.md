# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration derived from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Targets web development with TypeScript/JavaScript and PHP/Laravel.

## Architecture

- **Plugin manager:** lazy.nvim (bootstrapped in `lua/config/lazy.lua`)
- **Structure:** `init.lua` sets the leader and requires `lua/config/{options,lazy,keymaps,autocmds,test_runners}.lua`. Every plugin (including LSP, cmp, telescope, treesitter) is a lazy.nvim spec in `lua/plugins/*.lua`, auto-imported via `{ import = 'plugins' }`. Plugin-specific keymaps live in the spec (`keys` or `config`), not in `config/keymaps.lua`.

## Key Conventions

- **Leader key:** `<Space>`
- **Colorscheme:** `gruvbox`, set at the end of `init.lua` (overrides the `tokyonight` applied in `lua/plugins/colorschemes.lua`); `TransparentEnable` runs from `lua/plugins/ui.lua`
- **Window navigation:** `<C-h/j/k/l>`; LSP signature help is insert-mode `<C-k>`.
- **Framework gating:** laravel.nvim loads only when cwd has `artisan`; vim-rails (`lua/plugins/rails.lua`) only when cwd has `bin/rails`.
- **Keybinding namespaces:** `<leader>s*` = search/telescope, `<leader>l*` = Laravel, `<leader>fb*` = file browser, `<leader>r*` = test runners
- **LSP servers:** `ts_ls` (TypeScript), `lua_ls` (Lua), `ruby_lsp` (Ruby/Rails, auto-installed only when `gem` is on PATH), `rust_analyzer` (Rust), `gopls` (Go, requires the `go` toolchain on PATH). PHP uses `intelephense` via laravel.nvim. Managed by Mason + mason-lspconfig.
- **Formatting:** prettier via none-ls.nvim. JS/TS/JSX/TSX are excluded from format-on-save; CSS/HTML/JSON/YAML/Markdown/SCSS/GraphQL are formatted on save. Manual format: `<leader>f`.
- **Diagnostics:** Virtual text disabled globally. Use `<leader>e` (float) or `<leader>q` (loclist).
- **Treesitter:** Uses new API — `vim.treesitter.start()` via FileType autocmd for highlighting; `require('nvim-treesitter').setup()` for parser installation; `require('nvim-treesitter-textobjects').setup()` for text objects.

## Formatting

Lua files use [StyLua](https://github.com/JohnnyMorganz/StyLua): 160 column width, 2-space indent, single quotes (see `.stylua.toml`).

## Custom Test Runners

Defined in `lua/config/test_runners.lua` (local functions, no globals):
- `<leader>rf` / `<leader>rl` — `bundle exec rspec` on the file / current line in a split terminal
- `<leader>rp` — `php artisan test` on the current file

## Notable Quirks

- No AI plugins bundled — Claude Code runs in a separate terminal, not inside nvim.
- lualine is configured solely in `lua/plugins/lualine.lua` (bubbles theme).
- Git: `<leader>gg` opens lazygit in a floating terminal (requires `lazygit` on PATH); gitsigns hunk keymaps live under `<leader>h*` with `]c`/`[c` to navigate hunks.
- none-ls needs `eslint`/`prettier` resolvable (project-local `node_modules/.bin` or global); otherwise JS/TS formatting/linting silently no-ops.
