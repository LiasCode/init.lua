return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({ })

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
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
