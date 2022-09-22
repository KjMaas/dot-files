
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {

    marks = true,               -- shows a list of your marks on ' and `
    registers = true,           -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,           -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20,         -- how many suggestions should be shown in the list?
    },

    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true,         -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,           -- adds help for motions
      text_objects = true,      -- help for text objects triggered after entering an operator
      windows = true,           -- default bindings on <c-w>
      nav = true,               -- misc bindings to work with windows
      z = true,                 -- bindings for folds, spelling and others prefixed with z
      g = true,                 -- bindings for prefixed with g
    },

  },

  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },

  icons = {
    breadcrumb = "»",           -- symbol used in the command line area that shows your active key combo
    separator = "➜",            -- symbol used between a key and it's label
    group = "+",                -- symbol prepended to a group
  },

  popup_mappings = {
    scroll_down = '<c-d>',      -- binding to scroll down inside the popup
    scroll_up = '<c-u>',        -- binding to scroll up inside the popup
  },

  window = {
    border = "shadow",          -- none, single, double, shadow
    position = "bottom",        -- bottom, top
    margin = { 1, 0, 1, 0 },    -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 },   -- extra window padding [top, right, bottom, left]
    winblend = 0
  },

  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "center",               -- align columns left, center or right
  },

  ignore_missing = false,       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true,             -- show help message on the command line when the popup is visible
  triggers = "auto",            -- automatically setup triggers
  -- triggers = {"<leader>"}    -- or specify a list manually

  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },

  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },

}

local opts = {
  mode = "n",     -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {

  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Files" },
    s = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
  },

  g = {
    name = "Git",
    g = { "<cmd>abo :Git<CR>", "Fugitive" },
    L = { "<cmd>Git blame<cr>", "Blame File" },
    L = { "<cmd>Git blame<cr>", "Blame File" },
    C = { "<cmd>Git commit<cr>", "Commit" },
    d = { "<cmd>Gvdiffsplit<cr>", "Diff" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Previous Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

}

which_key.setup(setup)
which_key.register(mappings, opts)