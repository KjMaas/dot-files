local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "jsonls",
    -- "lua-language-server",
    "sumneko_lua",
    "pyright",
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = false,
})



-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
--   -- vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
--   return
-- end



-- local opts = {
--   on_attach = require("plugins.lsp.lspconfig").on_attach,
--   capabilities = require("plugins.lsp.lspconfig").capabilities,
-- }

-- mason_lspconfig.setup_handlers({
--   -- The first entry (without a key) will be the default handler
--   -- and will be called for each installed server that doesn't have
--   -- a dedicated handler.
--  function(server_name) -- Default handler (optional)
--     lspconfig[server_name].setup {
--       on_attach = opts.on_attach,
--       capabilities = opts.capabilities,
--     }
--   end,

-- --   ["sumneko_lua"] = function (server_name)
-- --     local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
-- --     local final_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
-- --     require("lspconfig")[server_name].setup(final_opts)
-- --   end,
-- ["sumneko_lua"] = function()
--   lspconfig.sumneko_lua.setup({
--     on_attach = opts.on_attach,
--     capabilities = opts.capabilities,

--     settings = {
--       Lua = {
--         -- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
--         diagnostics = {
--           globals = { "vim" },
--         },

--         workspace = {
--           library = {
--             [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--             [vim.fn.stdpath("config") .. "/lua"] = true,
--           },
--         },
--       },
--     },
--   })
-- end,


-- })
