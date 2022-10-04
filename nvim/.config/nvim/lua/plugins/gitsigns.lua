-- Configs for gitsigns plugin
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end


gitsigns.setup({

  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },

  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,      -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,     -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false,  -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },

  attach_to_untracked = true,

  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },

  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,

  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  yadm = {
    enable = false,
  },

})


-- Register mappings with which-key
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key")
  return
end

local mappings = {

  g = {
    name = "Git",
    G = { "<cmd>abo :Git<CR>", "Fugitive" },
    L = { "<cmd>Git blame<cr>", "Blame File" },
    C = { "<cmd>Git commit<cr>", "Commit" },
    D = { "<cmd>Gvdiffsplit<cr>", "Diff" },
    d = { "<cmd>lua require 'gitsigns'.toggle_deleted()<cr>", "Toggle Deleted Hunk" },
    b = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Current Line Blame" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Previous Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    h = { "<cmd>lua require 'gitsigns'.toggle_signs()<cr>", "Toggle Signs" },
    O = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
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
