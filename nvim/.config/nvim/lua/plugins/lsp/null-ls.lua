local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup{
  debug = false,

  sources = {
    null_ls.builtins.formatting.stylua.with({
      filetypes = { "lua" }
    }),

    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--prose-wrap", "always" },
    }),

    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.shellcheck.with({
        diagnostic_config = {
            -- see :help vim.diagnostic.config()
            underline = true,
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
        },
    }),

    -- -- Shows the first available definition for the current word under the cursor.
    -- null_ls.builtins.hover.dictionary,

    -- Lints and suggestions for the nix programming language.
    null_ls.builtins.code_actions.statix

  },

  -- -- format buffer on save
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
  --         vim.lsp.buf.formatting_sync()
  --       end,
  --     })
  --   end
  -- end,

}

local spell_active = false
function _G.toggle_spell()
  spell_active = not spell_active
  if spell_active then
    vim.api.nvim_echo({ { "Spelling ON" } }, false, {})
    vim.o.spell = true
  else
    vim.api.nvim_echo({ { "Spelling OFF" } }, false, {})
    vim.o.spell = false
  end
end

-- Register mappings with which-key
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key")
  return
end

local mappings = {

  n = {
    name = "Null-ls",

    i = { "<cmd>NullLsInfo<CR>", "Null-ls info"},

    s = { "<cmd>call v:lua.toggle_spell()<CR>", "Toggle Spelling ON/OFF" },

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
