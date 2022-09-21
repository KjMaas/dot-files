-- Keymap functions

local M = {}

function M.opts(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

return M
