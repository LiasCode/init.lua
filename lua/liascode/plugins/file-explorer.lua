---@type Array<LazyPluginSpec>
return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        auto_reload_on_write = true,
        disable_netrw = true,
        renderer = {
          hidden_display = "all"
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true
        },
        filters = {
          enable = false
        }
      })

      local nt_api = require("nvim-tree.api")

      vim.keymap.set({ "n", "i", "v", "t" }, '<C-l>', nt_api.tree.toggle, { desc = "Toggle file explorer" })
      vim.keymap.set({ "n" }, 'H', nt_api.tree.toggle_hidden_filter, { desc = "Toggle filter files" })
    end,
  }
}
