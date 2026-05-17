# AGENTS

## Repo shape (read this first)
- Neovim entrypoint is `init.lua`, which only loads `lua/liascode/init.lua`.
- Load order in `lua/liascode/init.lua` is intentional: `set` -> `maps` -> `lazy` -> `lsp`.
- Plugins are discovered via lazy.nvim spec namespace `liascode.plugins` (`lua/liascode/lazy.lua`), so add plugin specs under `lua/liascode/plugins/*.lua`.
- LSP server configs are auto-discovered from `lua/liascode/lsp/*.lua` by filename in `lua/liascode/lsp.lua`; adding/removing files there directly changes active servers.

## Verified commands
- Format all Lua files: `npx --yes @johnnymorganz/stylua-bin .`
- Fast startup/syntax check: `nvim --headless '+qa'`

## Formatting/source-of-truth
- StyLua config is enforced by `stylua.toml` at repo root (120 columns, 2 spaces, Unix line endings, prefer double quotes, always call parentheses).
- `README.md` documents the same StyLua command; keep `README.md` and `stylua.toml` aligned if formatting workflow changes.

## Gotchas that caused real breakage
- `lua/liascode/lsp.lua` is executed at startup; any syntax error there prevents Neovim from opening.
- After broad formatting or refactors, always run `nvim --headless '+qa'` before committing to catch startup-breaking Lua errors.

## Commits 

Always use conventional and semantic commits 
