-- General keymaps that are not pluggin dependant
-- the file "lua/lsp/utils.lua" contains lsp-specific commands.


local Utils = require('user.utils')
local opts = Utils.opts

local map = vim.keymap.set
local cmd = vim.cmd

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reload configuration files
map('n', "<leader>r", ":source $MYVIMRC<CR>", opts("reload NeoVim config."))

-- jk to normal mode
map('i', "jk", "<Esc>", opts("return to normal mode"))
-- scroll through wrapped lines
map('n', "j", "gj", opts(""))
map('n', "k", "gk", opts(""))
-- move lines up or down
map('i', "<A-j>", "<Esc>:m .+1<CR>==gi", opts("move line down")) 
map('i', "<A-k>", "<Esc>:m .-2<CR>==gi", opts("move line up")) 
map('n', "<A-j>", ":m .+1<CR>==", opts("move line down")) 
map('n', "<A-k>", ":m .-2<CR>==", opts("move line up")) 
map('v', "<A-j>", ":m '>+1<CR>gv=gv", opts("move line down"))
map('v', "<A-k>", ":m '<-2<CR>gv=gv", opts("move line up"))

-- Terminal window navigation
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  map('t', '<esc>', [[<C-\><C-n>]], opts)
  map('t', 'jk', [[<C-\><C-n>]], opts)
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Resize with arrows
map('n', "<C-Up>", ":resize +2<CR>", opts("Increase window width"))
map('n', "<C-Down>", ":resize -2<CR>", opts("Decrease window width"))
map('n', "<C-Left>", ":vertical resize -2<CR>", opts("Increase window height"))
map('n', "<C-Right>", ":vertical resize +2<CR>", opts("Decrease window height"))
map('i', "<C-Up>", "<Esc>:resize +2<CR>", opts("Increase window width"))
map('i', "<C-Down>", "<Esc>:resize -2<CR>", opts("Decrease window width"))
map('i', "<C-Left>", "<Esc>:vertical resize -2<CR>", opts("Increase window height"))
map('i', "<C-Right>", "<Esc>:vertical resize +2<CR>", opts("Decrease window height"))
map('v', "<C-Up>", "<Esc>:resize +2<CR>gv", opts("Increase window width"))
map('v', "<C-Down>", "<Esc>:resize -2<CR>gv", opts("Decrease window width"))
map('v', "<C-Left>", "<Esc>:vertical resize -2<CR>gv", opts("Increase window height"))
map('v', "<C-Right>", "<Esc>:vertical resize +2<CR>gv", opts("Decrease window height"))

-- Save with Ctrl + S
map('i', "<C-s>", "<Esc>:w<CR>", opts("save"))
map('n', "<C-s>", ":w<CR>", opts("save"))

-- Close Window
map('n', "<C-q>", "<C-w>c", opts("close window"))

-- Move around windows
map('n', "<C-h>", "<C-w>h", opts(""))
map('n', "<C-j>", "<C-w>j", opts(""))
map('n', "<C-k>", "<C-w>k", opts(""))
map('n', "<C-l>", "<C-w>l", opts(""))

-- Populate substitution
map('n', "<leader>s", ":s//g<Left><Left>", opts(""))
map('n', "<leader>S", ":%s//g<Left><Left>", opts(""))
map('n', "<leader><C-s>", ":%s//gc<Left><Left><Left>", opts(""))

map('v', "<leader>s", ":s//g<Left><Left>", opts(""))
map('v', "<leader><A-s>", ":%s//g<Left><Left>", opts(""))
map('v', "<leader>S", ":%s//gc<Left><Left><Left>", opts(""))

-- Copy to system clippboard
map('n', "<leader>y", '"+y', opts(""))
map('v', "<leader>y", '"+y', opts(""))

-- Paste from system clippboard
map('n', "<leader><C-v>", '"+p', opts(""))
map('v', "<leader><C-v>", '"+p', opts(""))

-- Open file in default application
map('n', "<leader>xo", "<Cmd> !xdg-open %<CR><CR>", opts("open in default app"))

-- -- Local list
-- map('n', "<leader>lo", ":lopen<CR>", opts(""))
-- map('n', "<leader>lc", ":lclose<CR>", opts(""))
-- map('n', "<C-n>", ":lnext<CR>", opts(""))
-- map('n', "<C-p>", ":lprev<CR>", opts(""))

-- -- Quickfix list
-- map('n', "<leader>co", ":copen<CR>", opts("open quickfix list"))
-- map('n', "<leader>cc", ":cclose<CR>", opts("close quickfix list"))
-- map('n', "<C-N>", ":cnext<CR>", opts("next on quickfix list"))
-- map('n', "<C-P>", ":cprev<CR>", opts("previous on quickfix list"))

-- Run omnifunc, mostly used for autocomplete
-- map('i', "<C-SPACE>", "<C-x><C-o>", opts(""))

-- -- Open local diagnostics in local list
-- map('n', "<leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>", opts(""))

-- -- Open all project diagnostics in quickfix list
-- map('n', "<leader><A-d>", "<Cmd>lua vim.diagnostic.setqflist()<CR>", opts(""))

-- Splits
-- map('n', "<leader>j", ":split<CR>", opts(""))
-- map('n', "<leader>l", ":vsplit<CR>", opts(""))

-- EasyAlign
-- xmap("ga", "<cmd>EasyAlign")
-- nmap("ga", "<cmd>EasyAlign")
