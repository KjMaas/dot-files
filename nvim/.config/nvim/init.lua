vim.env.MYVIMRC = "~/.config/nvim/init.lua"

local modules = {
  'user.options',
  'user.plugins',
  'user.keymaps',

  'plugins.bufferline',
  'plugins.lspconfig',
  'plugins.nnn',

  'plugins.nvimtree',
  'user.colors_base16',
}


print("sourcing MYVIMRC --> " .. vim.env.MYVIMRC)
for _, v in pairs(modules) do
  package.loaded[v]=nil
  print("--> " .. v)
  require(v)
end
print("Done!")
