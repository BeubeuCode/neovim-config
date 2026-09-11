# Beubeu's Neovim Config

Personal Neovim configuration derived from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), targeting web development (TypeScript/JavaScript) and PHP/Laravel.

## Installation

### Prerequisites

- Neovim 0.10.0 or newer
- Git
- A [Nerd Font](https://www.nerdfonts.com/) installed and selected in your terminal (icons in the tabline/statusline)
- `ripgrep` (Telescope live grep)
- `lazygit` (for `<leader>gg`)
- `tree-sitter-cli` (`brew install tree-sitter-cli`) if you need to install missing Treesitter parsers

### Setup

1. Clone the repo into your Neovim config folder
   ```bash
   git clone <repo> ~/.config/nvim
   ```
2. Launch Neovim — lazy.nvim bootstraps itself and installs plugins on first run
   ```bash
   nvim
   ```
3. Check plugin and LSP health
   ```vim
   :Lazy
   :Mason
   ```

## Structure

- `init.lua` — options, keymaps, LSP, completion, Treesitter, Telescope
- `lua/custom/plugins/*.lua` — one file per plugin, auto-loaded via `{ import = 'custom.plugins' }`

## Key points

- **Leader**: `<Space>`
- **Default colorscheme**: `gruvbox` (transparency enabled on startup)
- **LSP**: `ts_ls` (TypeScript/JS), `lua_ls` (Lua), `intelephense` via laravel.nvim (PHP/Laravel) — managed by Mason
- **Formatting**: prettier.nvim + none-ls (project-local `node_modules/.bin` binaries, falling back to global). JS/TS/JSX/TSX are excluded from format-on-save; CSS/HTML/JSON/YAML/Markdown/SCSS/GraphQL are formatted on save. Manual format: `<leader>f`
- **Diagnostics**: PHPStan/Larastan via none-ls, with `intelephense` noise filtered on Pest tests

## Key mappings

### Search (Telescope)

| Key | Action |
| --- | --- |
| `<leader>sf` | Search files |
| `<leader>sg` | Grep across the project |
| `<leader>sG` | Literal grep (special characters) |
| `<leader>sw` | Search word under cursor |
| `<leader>sh` | Search help tags |
| `<leader>sd` | List diagnostics |
| `<leader><space>` | Open buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>?` | Recently opened files |

### Files

| Key | Action |
| --- | --- |
| `-` | Open parent directory (Oil) |
| `<leader>ff` | Open Oil |
| `<leader>fb` | Toggle NvimTree |
| `<leader>yp` | Yank relative file path |
| `<leader>yl` | Yank relative path with line number |

### LSP & diagnostics

| Key | Action |
| --- | --- |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>e` | Open floating diagnostic |
| `<leader>q` | Diagnostics list (loclist) |

### Git

| Key | Action |
| --- | --- |
| `<leader>gg` | Lazygit (floating terminal) |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hd` | Diff current file |
| `]c` / `[c` | Navigate between hunks |

### Laravel

| Key | Action |
| --- | --- |
| `<leader>ll` | Laravel picker |
| `<leader>la` | Artisan picker |
| `<leader>lr` | Routes picker |
| `<leader>lm` | Make picker |
| `<leader>lc` | Commands picker |
| `<leader>lo` | Resources picker |
| `<c-g>` | View finder |

### Tests

| Key | Action |
| --- | --- |
| `<leader>rf` | Run current RSpec file |
| `<leader>rl` | Run current RSpec line |
| `<leader>rp` | Run Pest tests (`php artisan test`) |

### Misc

| Key | Action |
| --- | --- |
| `<leader>t` | Floating terminal |
| `<Tab>` / `<S-Tab>` | Next / previous tab |
| `<C-n>` / `<C-p>` | Next / previous buffer |
