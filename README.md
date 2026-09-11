# Config Neovim du beubeu

Config Neovim perso, basée sur [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), orientée dev web (TypeScript/JavaScript) et PHP/Laravel.

## Installation

### Prérequis

- Neovim 0.10.0 ou plus récent
- Git
- Un [Nerd Font](https://www.nerdfonts.com/) installé et sélectionné dans le terminal (icônes de la tabline/statusline)
- `ripgrep` (Telescope live grep)
- `lazygit` (pour `<leader>gg`)
- `tree-sitter-cli` (`brew install tree-sitter-cli`) si besoin d'installer des parsers Treesitter manquants

### Installation

1. Cloner le dépôt dans le dossier de configuration de Neovim
   ```bash
   git clone <repo> ~/.config/nvim
   ```
2. Lancer Neovim — lazy.nvim s'auto-installe et récupère les plugins au premier démarrage
   ```bash
   nvim
   ```
3. Vérifier l'état des plugins et LSP
   ```vim
   :Lazy
   :Mason
   ```

## Structure

- `init.lua` — options, keymaps, LSP, complétion, Treesitter, Telescope
- `lua/custom/plugins/*.lua` — un fichier par plugin, chargés automatiquement via `{ import = 'custom.plugins' }`

## Points clés

- **Leader** : `<Space>`
- **Colorscheme** par défaut : `gruvbox` (transparence activée au démarrage)
- **LSP** : `ts_ls` (TypeScript/JS), `lua_ls` (Lua), `intelephense` via laravel.nvim (PHP/Laravel) — gérés par Mason
- **Formatage** : prettier.nvim + none-ls (binaires project-local `node_modules/.bin` sinon globaux). JS/TS/JSX/TSX ne sont pas formatés à la sauvegarde ; CSS/HTML/JSON/YAML/Markdown/SCSS/GraphQL le sont. Format manuel : `<leader>f`
- **Diagnostics** : PHPStan/Larastan via none-ls, bruit `intelephense` filtré sur les tests Pest

## Raccourcis principaux

### Recherche (Telescope)

| Touche | Action |
| --- | --- |
| `<leader>sf` | Chercher des fichiers |
| `<leader>sg` | Grep dans le projet |
| `<leader>sG` | Grep littéral (caractères spéciaux) |
| `<leader>sw` | Chercher le mot sous le curseur |
| `<leader>sh` | Chercher dans l'aide |
| `<leader>sd` | Liste des diagnostics |
| `<leader><space>` | Buffers ouverts |
| `<leader>/` | Recherche floue dans le buffer courant |
| `<leader>?` | Fichiers récents |

### Fichiers

| Touche | Action |
| --- | --- |
| `-` | Ouvrir le dossier parent (Oil) |
| `<leader>ff` | Ouvrir Oil |
| `<leader>fb` | Toggle NvimTree |
| `<leader>yp` | Copier le chemin relatif du fichier |
| `<leader>yl` | Copier le chemin relatif avec numéro de ligne |

### LSP & diagnostics

| Touche | Action |
| --- | --- |
| `[d` / `]d` | Diagnostic précédent / suivant |
| `<leader>e` | Diagnostic en float |
| `<leader>q` | Liste des diagnostics (loclist) |

### Git

| Touche | Action |
| --- | --- |
| `<leader>gg` | Lazygit (terminal flottant) |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame de la ligne |
| `<leader>hd` | Diff du fichier |
| `]c` / `[c` | Naviguer entre les hunks |

### Laravel

| Touche | Action |
| --- | --- |
| `<leader>ll` | Picker Laravel |
| `<leader>la` | Picker Artisan |
| `<leader>lr` | Picker Routes |
| `<leader>lm` | Picker Make |
| `<leader>lc` | Picker Commands |
| `<leader>lo` | Picker Resources |
| `<c-g>` | View finder |

### Tests

| Touche | Action |
| --- | --- |
| `<leader>rf` | Lancer le fichier RSpec courant |
| `<leader>rl` | Lancer la ligne RSpec courante |
| `<leader>rp` | Lancer les tests Pest (`php artisan test`) |

### Divers

| Touche | Action |
| --- | --- |
| `<leader>t` | Terminal flottant |
| `<Tab>` / `<S-Tab>` | Onglet suivant / précédent |
| `<C-n>` / `<C-p>` | Buffer suivant / précédent |
