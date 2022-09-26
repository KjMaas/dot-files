-- Keymap functions

local M = {}

function M.opts(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end


-- function M.enable_transparent_mode()
--       local hl_groups = {
--         "Normal",
--         "LineNr",
--         "SignColumn",
--         "NormalNC",
--         -- "TelescopeBorder",
--         "NvimTreeNormal",
--         "EndOfBuffer",
--         "MsgArea",
--       }
--       for _, name in ipairs(hl_groups) do
--         vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
--       end
-- end


return M

