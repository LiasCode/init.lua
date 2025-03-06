return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,

      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 200,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- vim.keymap.set("n", "<leader>of", oil.toggle_float, { desc = "Open parent directory in float mode" })
  end
}
