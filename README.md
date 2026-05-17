# LiasCode Neovim config

Personal Neovim setup in Lua, focused on LSP workflows and editor productivity.

## Requirements

- Neovim (official install guide: https://github.com/neovim/neovim/blob/master/INSTALL.md)
- `git`
- `ripgrep` (used by search pickers)

## Installation

Clone this repo into your Neovim config path:

```bash
git clone https://github.com/LiasCode/init.lua.git ~/.config/nvim
```

## First run

On the first `nvim` launch:

- `lazy.nvim` is bootstrapped automatically (`lua/liascode/lazy.lua`)
- plugins from `lua/liascode/plugins/*.lua` are installed

## Quick plugin and utilities summary

- Plugin manager: `folke/lazy.nvim`
- Completion stack: `saghen/blink.cmp`, `friendly-snippets`, `blink-ripgrep.nvim`, `blink-copilot`
- LSP UX and diagnostics: native Neovim LSP + `nvimdev/lspsaga.nvim` + `folke/trouble.nvim`
- Search and navigation UI: `folke/snacks.nvim` pickers/explorer/terminal
- Syntax and structure: `nvim-treesitter` + `nvim-treesitter-context`
- Git tools: `lewis6991/gitsigns.nvim`, `tpope/vim-fugitive`
- Editing helpers: `autoclose.nvim`, `vim-sleuth`, `vim-vinegar`, `nvim-highlight-colors`
- Theme and visuals: `Mofiqul/vscode.nvim`, `nvim-web-devicons`, `colorful-menu.nvim`
- AI assistant integration: `nickjvandyke/opencode.nvim`

## Project structure

- `init.lua`: root entrypoint
- `lua/liascode/init.lua`: load order (`set` -> `maps` -> `lazy` -> `lsp`)
- `lua/liascode/plugins/*.lua`: plugin specs
- `lua/liascode/lsp.lua`: global LSP registration/enable flow
- `lua/liascode/lsp/*.lua`: per-server config (auto-discovered from filenames)

## Maintenance commands

### Format all Lua files (StyLua)

This repo uses [StyLua](https://github.com/JohnnyMorganz/StyLua) with `stylua.toml` at the repo root.

```bash
npx --yes @johnnymorganz/stylua-bin .
```

### Startup/syntax check

```bash
nvim --headless '+qa'
```

Run this after broad edits (especially changes in `lua/liascode/lsp.lua`) to catch startup-breaking syntax errors.

Inspired by [ThePrimeagen/init.lua](https://github.com/ThePrimeagen/init.lua).
