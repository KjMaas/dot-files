-- Visual
vim.o.conceallevel       = 0                            -- Don't hide quotes in markdown
vim.o.cmdheight          = 1
vim.o.pumheight          = 10
vim.o.showmode           = false
vim.o.showtabline        = 2                            -- Always show tabline
vim.o.title              = true
vim.o.termguicolors      = false                         -- Use true colors, required for some plugins
vim.wo.number            = true
vim.wo.relativenumber    = true
vim.wo.signcolumn        = 'yes'
vim.wo.cursorline        = true

-- Behaviour
vim.o.hlsearch           = true
vim.o.ignorecase         = true                         -- Ignore case when using lowercase in search
vim.o.smartcase          = true                         -- But don't ignore it when using upper case
vim.o.smarttab           = true
vim.o.smartindent        = true
vim.o.expandtab          = true                         -- Convert tabs to spaces.
vim.o.tabstop            = 4
vim.o.softtabstop        = 2
vim.o.shiftwidth         = 2
vim.o.splitbelow         = true
vim.o.splitright         = true
vim.o.scrolloff          = 12                           -- Minimum offset in lines to screen borders
vim.o.sidescrolloff      = 8
vim.o.mouse              = 'a'


-- Vim specific
vim.o.hidden             = true                         -- Do not save when switching buffers
vim.o.fileencoding       = "utf-8"
vim.o.spell              = false
vim.o.spelllang          = "en_us"
vim.o.completeopt        = "menuone,noinsert,noselect"
vim.o.wildmode           = "longest,full"               -- Display auto-complete in Command Mode
vim.o.updatetime         = 300                          -- Delay until write to Swap and HoldCommand event
vim.g.do_file_type_lua   = 1
-- Undo files
vim.o.undofile = true

-- Disable default plugins
vim.g.loaded_netrwPlugin = false                     -- This had an issue but I can't remember now.
-- timeout for mapped sequence completion
vim.o.timeoutlen = 500

-- Set clipboard to use system clipboard
vim.o.clipboard = "unnamedplus"


-- -- Python providers
-- -- local pynvim_env        = "/.local/bin/pyenv/versions/pynvim/"
-- -- vim.g.python3_host_prog = os.getenv("HOME")..pynvim_env.."/bin/python"
-- -- vim.g.black_virtualenv  = os.getenv("HOME")..pynvim_env

-- -- Disable unused providers
-- -- vim.g.loaded_perl_provider = 0
-- -- vim.g.loaded_ruby_provider = 0

-- -- Disable inline error messages
-- -- vim.diagnostic.config {
-- --   virtual_text = false,
-- --   underline = false,
-- --   signs = true,          -- Keep gutter signs
-- -- }
