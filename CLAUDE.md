# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration written in Lua, organized as a modular setup using **lazy.nvim** as the plugin manager.

## Architecture

```
init.lua                   # Entry point: sets leader keys, loads core modules, bootstraps lazy.nvim
lua/
  options.lua              # Vim options (indentation, search, UI)
  keymaps.lua              # Core keybindings (leader mappings, navigation)
  autocmds.lua             # Autocommands (yank highlight, diff close)
  user_commands.lua        # Custom commands: OpenRemote, CopyPath
  plugins/                 # One file per plugin; all auto-imported by lazy.nvim
```

**Plugin loading:** `init.lua` bootstraps lazy.nvim, then calls `require("lazy").setup({ { import = "plugins" } })`. Any `.lua` file placed in `lua/plugins/` is automatically picked up — no registration elsewhere needed.

**VS Code integration:** `init.lua` detects `vim.g.vscode` and syncs the clipboard. The `vscode.nvim` colorscheme is used to match VS Code visually.

## Key Conventions

- **Leader key:** `<Space>` (both `mapleader` and `maplocalleader`)
- **Indentation:** 4 spaces, `expandtab`, no line wrapping
- **Nerd font:** assumed present (`vim.g.have_nerd_font = true`)
- **Plugin config structure:** each plugin file returns a lazy.nvim spec table with `dependencies`, `config`/`opts`, and optional `keys` for lazy-loading

## Notable Plugin Roles

| Plugin | Role |
|--------|------|
| `snacks.nvim` | Primary picker (files, grep, buffers, projects), dashboard, lazygit, explorer (`\`) |
| `telescope.nvim` | Secondary fuzzy finder (diagnostics `<leader>sd`, buffer search `<leader>/`) |
| `blink.cmp` + `LuaSnip` | Autocompletion (`<C-y>` accept, `<C-space>` toggle) |
| `nvim-lspconfig` + `mason.nvim` | LSP setup; only `pyright` and `lua_ls` are explicitly configured |
| `conform.nvim` | Format-on-save (LSP fallback); `stylua` for Lua |
| `gitsigns.nvim` | Hunk navigation (`]c`/`[c`), staging, blame, diff |
| `mini.files` | File browser relative to current file (`-`) |
| `csvview.nvim` | Auto-enabled for `.csv` files |

## Adding a New Plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. It will be loaded automatically on next startup or `:Lazy sync`.

## No Build/Test Commands

This is a config-only repo. Changes take effect by restarting Neovim or running `:Lazy reload <plugin>`. Use `:checkhealth` to diagnose issues.
