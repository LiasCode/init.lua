return {
  'stevearc/oil.nvim',

  dependencies = { { "echasnovski/mini.icons", opts = {} } },

  lazy = false,

  config = function()
    require("oil").setup {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,

      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
      },

      watch_for_changes = true,

      keymaps = {
        ["<C-p>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
    }

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)

  end
}
