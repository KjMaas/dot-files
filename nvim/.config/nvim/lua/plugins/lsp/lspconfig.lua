local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end


local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,

  signs = {
    active = signs,
  },

  update_in_insert = false,
  underline = true,
  severity_sort = true,

  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },

}

vim.diagnostic.config(config)

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "rounded",
-- })

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = "rounded",
-- })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require('lspconfig')['sumneko_lua'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua',
          vim.api.nvim_get_runtime_file("", true)
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig')['remark_ls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

-- require('lspconfig')['marksman'].setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
-- }

require('lspconfig')['rnix'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}


-- Toogle diagnostics
-- also check: https://github.com/neovim/neovim/issues/14825
local diagnostics_active = true
function _G.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.disable()
  end
end


-- Register mappings with which-key
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key")
  return
end

local mappings = {

  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<cr>", "Info" },

    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    -- d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics", },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    -- w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics", },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- s = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" },

    f = { "<cmd>lua vim.diagnostic.open_float()<CR>", "open float" },
    F = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic", },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
    q = { "<cmd>lua vim.diagnostic.set_loclist()<cr>", "Quickfix" },

    D = { "<cmd>call v:lua.toggle_diagnostics()<CR>", "toggle in-line diagnostics" },

    m = { "<cmd>Mason<cr>", "Mason (Insall LSPs)" },
  },
}


local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(mappings, opts)
