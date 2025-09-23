local lsp_dir = vim.fn.expand('~/.config/nvim/lua/liascode/lsp')

-- 1) Capabilities from blink
local ok_blink, blink = pcall(require, 'blink.cmp')

local capabilities = vim.lsp.protocol.make_client_capabilities()

if ok_blink and blink.get_lsp_capabilities then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

-- 2) Load & register each server config file
--    File names become config names: lsp/<name>.lua -> name
---@type table<string, { cfg:vim.lsp.Config }>
local registered = {}

for name, t in vim.fs.dir(lsp_dir) do
  if t == "file" and name:match("%.lua$") and name ~= "init.lua" then
    local server = name:gsub("%.lua$", "")
    local ok, cfg = pcall(require, "liascode.lsp." .. server)
    if ok and type(cfg) == "table" then
      -- inject capabilities unless user explicitly set them
      if cfg.capabilities == nil then
        cfg.capabilities = capabilities
      end

      vim.lsp.config(server, cfg) -- << register the named config
      registered[server] = { cfg = cfg }
    else
      vim.notify(("LSP: failed to load %s: %s"):format(server, tostring(cfg)), vim.log.levels.WARN, { title = "LSP" })
    end
  end
end

-- 3) Globally enable all registered servers (they still attach by filetype/root)
--    If you prefer per-buffer enabling only, you can skip this and rely on autocmds below.
for server, _ in pairs(registered) do
  vim.lsp.enable(server)
end

-- 4) Your diagnostics & inlay hints
vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN]  = "󰀪",
      [vim.diagnostic.severity.INFO]  = "󰋽",
      [vim.diagnostic.severity.HINT]  = "󰌶",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN]  = "WarningMsg",
    },
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    scope = "line",
  }
})
