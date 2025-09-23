vim.g.mapleader = ' ';

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true });

vim.keymap.set("n", "Q", "<nop>");
vim.keymap.set({ "n", "i", "v", "x" }, "<C-l>", "<Esc>");

vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv"); vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");

vim.keymap.set("n", "J", "mzJ`z");
vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");
vim.keymap.set("n", "n", "nzzzv");
vim.keymap.set("n", "N", "Nzzzv");

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]);

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]);
vim.keymap.set("n", "<leader>Y", [["+Y]]);

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]);

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>");

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
});

-- vim.keymap.set("n", "<leader>ef", function() vim.cmd 'Ex' end);
vim.keymap.set("n", "<C-n>", function() vim.cmd 'bnext' end);
vim.keymap.set("n", "<leader>rb", function() vim.cmd 'bdelete' end);

-- Exit from terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--- LSP
local function show_diagnostics()
  vim.diagnostic.open_float({
    scope = "cursor"
  })
end

vim.keymap.set('n', '<Leader>e', show_diagnostics, { desc = 'Show diagnostics' })

local function format_buffer()
  vim.lsp.buf.format({
    async = true
  })
end

vim.keymap.set('n', '<Leader>fo', format_buffer, { desc = 'Format buffer' })


local function code_actions()
  vim.lsp.buf.code_action({})
end

vim.keymap.set('n', '<Leader>ca', code_actions, { desc = 'Code Actions' })
