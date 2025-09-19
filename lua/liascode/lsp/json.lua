---@type vim.lsp.Config
return {
  -- depending on your distro, binary can be "vscode-json-language-server" or "json-languageserver"
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git", "package.json" },
  init_options = { provideFormatter = true },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas({}),
      validate = { enable = true },
    },
  },
}

