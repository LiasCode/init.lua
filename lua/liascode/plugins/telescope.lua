return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "kkharji/sqlite.lua",
  },

  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { "dune.lock" },
      },
      extensions = {
        wrap_results = true,
        fzf = {},
      },
    })

    local builtin = require('telescope.builtin')

    pcall(require("telescope").load_extension, "fzf")

    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<C-P>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    vim.keymap.set('n', '<leader>sw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>sW', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>sg', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
  end
}
