# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration derived from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Targets web development with TypeScript/JavaScript and PHP/Laravel.

## Architecture

- **Plugin manager:** lazy.nvim (bootstrapped in `init.lua`)
- **Structure:** Hybrid monolith — `init.lua` (~640 lines) contains core config (options, keymaps, LSP, completion, treesitter, telescope). Custom plugins live in `lua/custom/plugins/*.lua`, each returning a lazy.nvim spec, auto-imported via `{ import = 'custom.plugins' }`.
- **Disabled modules:** `lua/kickstart/plugins/autoformat.lua` and `lua/kickstart/plugins/debug.lua` exist but are commented out in the lazy spec.

## Key Conventions

- **Leader key:** `<Space>`
- **Colorscheme:** `ayu-dark` (with `TransparentEnable` on startup)
- **Keybinding namespaces:** `<leader>s*` = search/telescope, `<leader>l*` = Laravel, `<leader>fb*` = file browser, `<leader>r*` = test runners
- **LSP servers:** `ts_ls` (TypeScript), `lua_ls` (Lua). PHP uses `intelephense` via laravel.nvim. Managed by Mason + mason-lspconfig.
- **Formatting:** prettier.nvim + none-ls.nvim. JS/TS/JSX/TSX are excluded from format-on-save; CSS/HTML/JSON/YAML/Markdown/SCSS/GraphQL are formatted on save. Manual format: `<leader>f`.
- **Diagnostics:** Virtual text disabled globally. Use `<leader>e` (float) or `<leader>q` (loclist).
- **Treesitter:** Uses new API — `vim.treesitter.start()` via FileType autocmd for highlighting; `require('nvim-treesitter').setup()` for parser installation; `require('nvim-treesitter-textobjects').setup()` for text objects.

## Formatting

Lua files use [StyLua](https://github.com/JohnnyMorganz/StyLua): 160 column width, 2-space indent, single quotes (see `.stylua.toml`).

## Custom Test Runners

Global functions defined in `init.lua`:
- `RunRspecFile()` / `RunRspecLine()` — runs `bundle exec rspec` in a split terminal (`<leader>rf`, `<leader>rl`)
- `RunPestFile()` — runs `php artisan test` in a split terminal (`<leader>rp`)

## Notable Quirks

- `github/copilot.vim` and `zbirenbaum/copilot.lua` are both installed (the latter is a CopilotChat dependency)
- Some plugins are declared twice (vscode.nvim, Comment.nvim, mason.nvim) — lazy.nvim deduplicates them
- `lua/custom/plugins/lualine.lua` returns `{}` (disabled); lualine is configured in `init.lua`
