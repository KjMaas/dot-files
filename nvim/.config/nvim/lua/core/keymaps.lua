local function map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts)
end

map('n', '<A-r>', '<cmd>lua reload_nvim_conf()<CR>')
