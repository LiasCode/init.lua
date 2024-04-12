vim.o.mouse = 'a'
vim.o.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'

vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.opt.smartindent = true
vim.opt.swapfile = false

vim.opt.backup = false

vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.softtabstop = 2

vim.opt.incsearch = true
vim.o.hlsearch = false

vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
