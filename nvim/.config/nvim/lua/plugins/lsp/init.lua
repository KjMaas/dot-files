-- import LSP config, our installer and our handlers

local modules = {
  'lua-dev',
  'mason',
  'mason-lspconfig',
  'lspconfig',
  'null-ls',
}

for _, v in pairs(modules) do
  package.loaded["plugins.lsp." .. v]=nil
  print("    --> " .. v)
  require("plugins.lsp." .. v)
end
