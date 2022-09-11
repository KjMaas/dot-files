local opts = { noremap=true, silent=false }
-- vim.keymap.set('n', "<C-n>"  , "<cmd>NnnExplorer %:p:h<CR>", opts)
vim.keymap.set('n', "<C-A-n>"  , "<cmd>NnnPicker %:p:h<CR>", opts)
vim.keymap.set('i', "<C-A-n>"  , "<Esc><cmd>NnnPicker %:p:h<CR>", opts)
vim.keymap.set('t', "<C-A-n>"  , "<cmd>NnnPicker %:p:h<CR>", opts)


local nnn = require("nnn")
nnn.setup({

  explorer = {
		cmd = "nnn",       -- command overrride (-F1 flag is implied, -a flag is invalid!)
		width = 24,        -- width of the vertical split
		side = "topleft",  -- or "botright", location of the explorer window
		session = "local", -- or "global" / "local" / "shared"
		tabs = true,       -- seperate nnn instance per tab
	},

	picker = {
		cmd = "nnn",       -- command override (-p flag is implied)
		style = {
			width = 0.3,     -- percentage relative to terminal size when < 1, absolute otherwise
			height = 0.5,    -- ^
			xoffset = 0.95,   -- ^
			yoffset = 0.5,   -- ^
			border = "rounded"-- border decoration for example "rounded"(:h nvim_open_win)
		},
		session = "global",      -- or "global" / "local" / "shared"
	},

	auto_open = {
		setup = nil,       -- or "explorer" / "picker", auto open on setup function
		tabpage = nil,     -- or "explorer" / "picker", auto open when opening new tabpage
		empty = true,     -- only auto open on empty buffer
		ft_ignore = {      -- dont auto open for these filetypes
			"gitcommit",
		}
	},

	auto_close = true,  -- close tabpage/nvim when nnn is last window
	replace_netrw = "nil", -- or "explorer" / "picker"

	windownav = {        -- window movement mappings to navigate out of nnn
		left = "<C-h>",
		right = "<C-l>",
		next = "<C-j>",
		prev = "<C-k>",
	},

	buflisted = false,   -- whether or not nnn buffers show up in the bufferlist
	quitcd = "tcd",      -- or "cd" / "lcd", command to run if quitcd file is found
	offset = false,      -- whether or not to write position offset to tmpfile(for use in preview-tui)

  mappings = {
    { "<C-A-t>", nnn.builtin.open_in_tab },      -- open file(s) in tab
    { "<C-A-s>", nnn.builtin.open_in_split },    -- open file(s) in split
    { "<C-A-v>", nnn.builtin.open_in_vsplit },   -- open file(s) in vertical split
    { "<C-A-y>", nnn.builtin.copy_to_clipboard },-- copy file(s) to clipboard
    { "<C-A-w>", nnn.builtin.cd_to_path },       -- cd to file directory
    { "<C-A-p>", nnn.builtin.open_in_preview },  -- open file in preview split keeping nnn focused
    { "<C-A-e>", nnn.builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
  },
})
