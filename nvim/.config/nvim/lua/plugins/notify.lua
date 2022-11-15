local status_ok, notify = pcall(require, "notify")
if not status_ok then
  function notify_on_pcall_fail(opts)
    vim.notify(opts)
  end
  notify_on_pcall_fail(notify)
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
  max_width = 30,
  render = "minimal",
  stages = "fade_in_slide_out",
  timeout = 3000,
  top_down = false

})


-- set the default notifications to nvim-notify (this plugin)
vim.notify = notify


function notify_on_pcall_fail(opts)
  vim.notify(
    opts, "error",
    { title="Failed to load package", timeout=10000, render="default"}
  )
end

