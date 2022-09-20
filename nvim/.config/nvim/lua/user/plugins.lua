-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn

-- Boostrap Packer (Automatically install packer if it's not already installed)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, please close and reopen Neovim...")
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Rerun PackerCompile and PackerSync everytime plugins.lua is updated
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer could not be loaded, check config")
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})


-- Initialize pluggins
return packer.startup(function(use)
  use({'wbthomason/packer.nvim', opt=false}) -- Let Packer manage itself
  use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

  -- LSP or Language Server Protocol. Used for linting and more advanced language completions
  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',  -- Helper for installing most language servers
      "williamboman/mason.nvim",          -- LSP installer
      "williamboman/mason-lspconfig.nvim",-- Helper to make LSP installer work nicer with nvim-lspconfig
      "neovim/nvim-lspconfig",            -- enable LSP
      "jose-elias-alvarez/null-ls.nvim",  -- null-ls - formatting and style linting
      "folke/trouble.nvim",               -- Make it easier to read through diagnostics
    },
    config = function() require('plugins.lsp') end,
  })

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",           -- The completion plugin
    requires = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-buffer",       -- buffer completions
      "hrsh7th/cmp-path",         -- path completions
      "hrsh7th/cmp-nvim-lua",     -- Lua-specific completions
      "hrsh7th/cmp-cmdline",      -- command-line completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function() require('plugins.cmp') end,
  })

  -- Snippets
  use {"L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end}
  use "rafamadriz/friendly-snippets"

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  })

  -- -- Signature help
  -- use "ray-x/lsp_signature.nvim"

  -- Telescope, Da fuzzy finder
  use({
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    config = function() require('plugins.telescope') end,
  })

  -- use({'nvim-telescope/telescope-fzf-native.nvim', run ='make'})

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  })

  -- statusline
  use({
      'nvim-lualine/lualine.nvim',
      config = function() require('plugins.lualine') end,
    })

    -- NvimTree
    use({
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require('plugins.nvimtree') end,  -- Must add this manually
    })

    -- nnn (file explorer/manager)
    use({
      'luukvbaal/nnn.nvim',
      config = function() require('plugins.nnn') end
    })

    -- terminal
    use({
      "akinsho/toggleterm.nvim",
      tag = '*',
      config = function() require("plugins.toggleterm") end
    })

    -- -- Startify./../
    -- use({
      --   'mhinz/vim-startify',
      --   config = function()
        --     local path = vim.fn.stdpath('config')..'/lua/plugins/startify.vim'
        --     vim.cmd('source '..path)
        --   end
        -- })

        -- Git - the extensions that add git support
        use("tpope/vim-fugitive") -- Another git client
        use({
          'lewis6991/gitsigns.nvim', -- Git support (like showing which lines are added or removed) 
          requires = {'nvim-lua/plenary.nvim'},
          config = function() require('plugins.gitsigns') end
        })

        -- Formatting
        use ({
          "windwp/nvim-autopairs", -- if you insert an open parantheses, automatically add the closing one, works with CMP and Treesitter 
          config = function() require('plugins.autopairs') end
        }) 
        use ({
          "numToStr/Comment.nvim", -- easily comment stuff by hitting gc 
          config = function() require('plugins.comment') end
        })
        use("JoosepAlviste/nvim-ts-context-commentstring") -- fancier commenting. It can figure out if something is, like, JSX. Works with Treesitter
        use("moll/vim-bbye") -- allows you to close bufferrs without closing windows or messing up layout

        -- use 'tpope/vim-commentary'
        -- use 'tpope/vim-unimpaired'
        use 'tpope/vim-surround'
        use 'tpope/vim-speeddating'
        use 'tpope/vim-repeat'
        use 'junegunn/vim-easy-align'

        -- Python formatting
        -- use "EgZvor/vim-black"
        -- use 'jeetsukumaran/vim-python-indent-black'

        -- Python
        -- use  'heavenshell/vim-pydocstring'   -- Overwrites a keymap, need to fix.
        -- use 'bfredl/nvim-ipy'

        -- -- Markdown
        -- use 'godlygeek/tabular'
        -- use 'ellisonleao/glow.nvim'
        use ({ 
          "iamcco/markdown-preview.nvim",
          run = "cd app && npm install",
          ft = "markdown",
          -- ToDo: configuration (https://github.com/iamcco/markdown-preview.nvim)
          config = function()
            vim.g.mkdp_auto_start = 1
          end,
        })

        -- -- TOML Files
        -- use 'cespare/vim-toml'

        -- -- Poetry
        -- -- use({'petobens/poet-v',
        -- --   config = function()
          -- --     local path = vim.fn.stdpath('config')..'/lua/plugins/poet-v.vim'
          -- --     vim.cmd('source '..path)
          -- --   end
          -- -- })

          -- -- kitty config syntax-highlight
          -- use "fladson/vim-kitty"

          -- -- note taking with zettelkasten

          -- -- Themes
          -- use 'folke/tokyonight.nvim'
          -- use 'marko-cerovac/material.nvim'
          use 'RRethy/nvim-base16'
          use 'chrisbra/Colorizer'

          -- WhichKey
          use({
            "folke/which-key.nvim",
            config = function() require("plugins.which-key") end
          })


          if packer_bootstrap then
            require('packer').sync()
          end
        end)
