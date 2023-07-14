vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true });
vim.keymap.set("n", "Q", "<nop>");
vim.keymap.set({ "n", "i", "v", "x" }, "<C-l>", "<Esc>");
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format);

vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");

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

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true });
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true });

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
});


