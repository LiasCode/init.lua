---@type LazyPluginSpec
return {
  "Mofiqul/vscode.nvim",
  config = function()
    local c = require('vscode.colors').get_colors()

    require('vscode').setup({
      -- Alternatively set style in setup
      style = 'dark',

      -- Enable transparent background
      transparent = false,

      -- Enable italic comment
      italic_comments = false,

      -- Enable italic inlay type hints
      italic_inlayhints = true,

      -- Underline `@markup.link.*` variants
      underline_links = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Apply theme colors to terminal
      terminal_colors = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = '#FFFFFF',
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      }
    })

    vim.cmd.colorscheme "vscode"
  end
}
