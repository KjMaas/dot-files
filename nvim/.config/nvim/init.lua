vim.env.MYVIMRC = "~/.config/nvim/init.lua"


-- local transparent_window = true
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

local modules = {
  'user.utils',
  'user.options',
  'user.plugins',
  'user.keymaps',

  'plugins.barbar',
  'plugins.comment',
  'plugins.gitsigns',
  'plugins.lightspeed',
  'plugins.lualine',
  'plugins.project',

  'plugins.treesitter',
  'plugins.neuron',
  'plugins.markdown-preview',

  'plugins.lsp',
  'plugins.dap',
  'plugins.cmp',
  'plugins.luasnip',

  'plugins.nnn',
  'plugins.nvimtree',
  'plugins.telescope',
  'plugins.toggleterm',

  'plugins.which-key',

  'user.colorscheme',
}


print("sourcing MYVIMRC --> " .. vim.env.MYVIMRC)
for _, v in pairs(modules) do
  package.loaded[v] = nil
  print("--> " .. v)
  require(v)
end

-- local Utils = require('user.utils')
-- if transparent_window then
--   Utils.enable_transparent_mode()
-- end

-- vim.cmd [[colorscheme catppuccin]]

print("Done!")
