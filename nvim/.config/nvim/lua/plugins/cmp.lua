-- Settings for the autocomplete plugin
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
  -- Don't autocomplete, otherwise there is too much clutter
  -- completion = {autocomplete = { false },},

  -- Don't preselect an option
  preselect = cmp.PreselectMode.None,

  -- Snippet engine, required (for 'luasnip')
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    -- open/close autocomplete
    ['<C-Space>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end,

    ['<C-c>'] = cmp.mapping.close(),

    -- select completion
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),

    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
    "i",
    "s",
  }),

  ["<C-k>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
  "i",
  "s",
}),

-- Scroll documentation
['<C-d>'] = cmp.mapping.scroll_docs(-4),
['<C-f>'] = cmp.mapping.scroll_docs(4),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[NVIM_LUA]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },

  -- Complete options from the LSP servers and the snippet engine
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'nvim_lua'},
    {name = 'path'},
    {name = 'buffer'},
    {name = 'spell'},
    -- {name = 'calc'},
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    documentation = cmp.config.window.bordered(),
  },

  experimental = {
    ghost_text = false,
    native_menu = false,
  },

  -- ToDo: DAP
  -- enabled = function()
  --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --   or require("cmp_dap").is_dap_buffer()
  -- end

})
