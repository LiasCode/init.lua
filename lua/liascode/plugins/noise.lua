return {
  'folke/noice.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  opts = {
    lsp = {
      progress = { enabled = false },
      signature = { enabled = false },
    },
    notify = { enabled = false },
  }
}
