local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  notify_on_pcall_fail(colorizer)
  return
end


colorizer.setup {
  filetypes = { "*" },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "background", -- Set the display mode.

    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = false, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { css }, }, -- Enable sass colors
    virtualtext = "■",
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {
    "*",
    -- exclude prompt and popup buftypes from highlight
    "!prompt",
    "!popup",
  },
}


-- Register mappings with which-key
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key")
  return
end

local mappings = {

  c = {
    name = "Colorizer",
    a = { "<cmd>ColorizerAttachToBuffer<cr>", "Attach to Buffer" },
    d = { "<cmd>ColorizerDetachFromBuffer<cr>", "Detach from Buffer" },
    r = { "<cmd>ColorizerReloadAllBuffers<cr>", "Reload Configuration" },
    c = { "<cmd>ColorizerToggle<cr>", "Toggle Color ON/OFF" },
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
