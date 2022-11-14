local status_ok, notify = pcall(require, "notify")
if not status_ok then
  print("ISSUE WITH PACKAGE: nvim-notify")
  return
end


notify.setup({
  background_colour = "#000000",
  fps = 30,

  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },

  level = 2,
  minimum_width = 0,
  max_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 5000,
  top_down = false

})

vim.notify = require("notify")
vim.notify("welcome back!")
