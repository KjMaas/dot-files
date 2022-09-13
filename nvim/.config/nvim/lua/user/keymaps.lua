-- General keymaps that are not pluggin dependant
-- the file "lua/lsp/utils.lua" contains lsp-specific commands.


local Utils = require('user.utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
-- local nmap = Utils.nmap
-- local xmap = Utils.xmap

vim.g.mapleader = " "
vim.g.maplocalleader = " "



-- Reload configuration files
inoremap("<leader>r", "<Esc>:source $MYVIMRC<CR>")
nnoremap("<leader>r", ":source $MYVIMRC<CR>")

-- jk to normal mode
inoremap("jk", "<Esc>")
-- scroll through wrapped lines
nnoremap("j", "gj")
nnoremap("k", "gk")
-- move lines up or down
inoremap("<A-j>", "<Esc>:m .+1<CR>==gi") 
inoremap("<A-k>", "<Esc>:m .-2<CR>==gi") 
nnoremap("<A-j>", ":m .+1<CR>==") 
nnoremap("<A-k>", ":m .-2<CR>==") 
vnoremap("<A-j>", ":m '<+1<CR>gv-gv")
vnoremap("<A-k>", ":m '<-2<CR>gv-gv")


-- Terminal window navigation
tnoremap("<C-j>", "<C-\\><C-N><C-w>j")
tnoremap("<C-h>", "<C-\\><C-N><C-w>h")
tnoremap("<C-k>", "<C-\\><C-N><C-w>k")
tnoremap("<C-l>", "<C-\\><C-N><C-w>l")



-- Run omnifunc, mostly used for autocomplete
inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
inoremap("<C-s>", "<Esc>:w<CR>")
nnoremap("<C-s>", ":w<CR>")

-- Close buffer
nnoremap("<C-c>", ":q<CR>")

-- Close Window
nnoremap("<C-q>", "<C-w>c")

-- Move around windows (shifted to the right)
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Switch buffers (needs nvim-bufferline)
nnoremap("<S-l>", ":BufferLineCycleNext<CR>")
nnoremap("<S-h>", ":BufferLineCyclePrev<CR>")

-- Splits
nnoremap("<leader>j", ":split<CR>")
nnoremap("<leader>l", ":vsplit<CR>")

-- Populate substitution
nnoremap("<leader>s", ":s//g<Left><Left>")
nnoremap("<leader>S", ":%s//g<Left><Left>")
nnoremap("<leader><C-s>", ":%s//gc<Left><Left><Left>")

vnoremap("<leader>s", ":s//g<Left><Left>")
vnoremap("<leader><A-s>", ":%s//g<Left><Left>")
vnoremap("<leader>S", ":%s//gc<Left><Left><Left>")

-- Delete buffer
nnoremap("<A-w>", ":bd<CR>")

-- Copy to system clippboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')

-- Paste from system clippboard
nnoremap("<leader><C-v>", '"+p')
vnoremap("<leader><C-v>", '"+p')

-- Clear highlight search
nnoremap("<leader>h", ":nohlsearch<CR>")
vnoremap("<leader>h", ":nohlsearch<CR>")

-- Local list
nnoremap("<leader>lo", ":lopen<CR>")
nnoremap("<leader>lc", ":lclose<CR>")
nnoremap("<C-n>", ":lnext<CR>")
nnoremap("<C-p>", ":lprev<CR>")

-- Quickfix list
nnoremap("<leader>co", ":copen<CR>")
nnoremap("<leader>cc", ":cclose<CR>")
nnoremap("<C-N>", ":cnext<CR>")
nnoremap("<C-P>", ":cprev<CR>")

-- Open file in default application
nnoremap("<leader>xo", "<Cmd> !xdg-open %<CR><CR>")

-- Fugitive
nnoremap("<leader>G", ":G<CR>")

-- Show line diagnostics
nnoremap("<leader>d", '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
nnoremap("<leader>D", "<Cmd>lua vim.diagnostic.setloclist()<CR>")

-- Open all project diagnostics in quickfix list
nnoremap("<leader><A-d>", "<Cmd>lua vim.diagnostic.setqflist()<CR>")

-- Telescope
nnoremap("<leader>ff", "<Cmd>Telescope find_files<CR>")
nnoremap("<leader>fhf","<Cmd>Telescope find_files hidden=true<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers<CR>")
nnoremap("<leader>fg", "<Cmd>Telescope live_grep<CR>")

-- File explorer
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")  -- NvimTree
-- nnoremap("<leader>e", "<Cmd>RnvimrToggle<CR>")

-- EasyAlign
-- xmap("ga", "<cmd>EasyAlign")
-- nmap("ga", "<cmd>EasyAlign")
