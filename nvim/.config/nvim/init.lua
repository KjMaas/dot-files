vim.env.MYVIMRC = "~/.config/nvim/init.lua"

local modules = {
  'user.options',
  'user.plugins',
  'user.keymaps',

  'plugins.barbar',
  'plugins.gitsigns',
  'plugins.lualine',
  'plugins.treesitter',

  'plugins.cmp',
  'plugins.lsp.init',

  'plugins.nnn',
  'plugins.nvimtree',
  'plugins.telescope',

  'plugins.which-key',

  'user.colors_base16',
}


print("sourcing MYVIMRC --> " .. vim.env.MYVIMRC)
for _, v in pairs(modules) do
  package.loaded[v]=nil
  print("--> " .. v)
  require(v)
end
print("Done!")
