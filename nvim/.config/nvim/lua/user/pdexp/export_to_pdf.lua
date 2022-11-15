local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"


local attach_to_buffer = function(bufnb, pattern, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("pandoc", { clear = true}),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnb, -1, -1, false, data)
        end
      end
      vim.fn.jobstart(command, {
        stdout_buffered =true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end


-- select script file to run
local set_script_file = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Choose script file",

    finder = finders.new_oneshot_job({ "find" }, opts ),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()[1]
        -- print(vim.inspect(selection))
        vim.api.nvim_buf_set_lines(LOGS_BUFNR, 2, 3, false, { "script file: " .. selection })

        local script = vim.api.nvim_buf_get_lines(LOGS_BUFNR, 2, 3, false)[1]:match("%./.*sh")
        local command = { "bash", script }
        -- print(vim.inspect(command))

        -- local bufnb = tonumber(vim.fn.input "Bufnr: ")
        local trigger_files = vim.api.nvim_buf_get_lines(LOGS_BUFNR, 3, 4, false)[1]:match(":(.*)")
        -- cleanup string (remove spaces and hard-coded quotes)
        trigger_files = trigger_files:gsub("[' \"]", "")
        -- parse string to extract individual trigger files (delimiter=",")
        local pattern = {};
        for file in (trigger_files..","):gmatch("(.-)"..",") do
          table.insert(pattern, file)
        end
        -- local pattern = { "cv.md", "style.css" }
        vim.api.nvim_buf_set_lines(LOGS_BUFNR, 4, 5, false, pattern)

        -- local pattern = vim.fn.input "Pattern: "
        attach_to_buffer(LOGS_BUFNR, pattern, command)

      end)
      return true
    end,

    sorter = conf.generic_sorter(opts),

  }):find()
end



-- our picker function: choose logging file
local set_logging_buf = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Choose logging file",

    finder = finders.new_oneshot_job({ "find" }, opts ),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()[1]
        -- store current buffer number
        local curr_bufnr = vim.api.nvim_get_current_buf()
        -- open buffer with logs
        vim.api.nvim_command("edit " .. selection)
        -- local logs_bufnr = tonumber(vim.api.nvim_get_current_buf())
        LOGS_BUFNR = tonumber(vim.api.nvim_get_current_buf())
        -- write variables to chosen logs file
        vim.api.nvim_buf_set_lines(LOGS_BUFNR, 0, 1, false, { "current buffer: " .. curr_bufnr })
        vim.api.nvim_buf_set_lines(LOGS_BUFNR, 1, 2, false, { "logs buffer: " .. LOGS_BUFNR })
        -- return to previous buffer
        vim.api.nvim_command("buffer " .. curr_bufnr)

        -- choose script file to execute
        set_script_file(require("telescope.themes").get_dropdown{})

      end)
      return true
    end,

    sorter = conf.generic_sorter(opts),

  }):find()
end



-- set_logging_buf(require("telescope.themes").get_dropdown{})

vim.api.nvim_create_user_command("GeneratePDF", function()
  print("Setting up Autorun for PDF generation...")

  -- choose logging, scrip and trigger files
  set_logging_buf(require("telescope.themes").get_dropdown{})

  -- local bufnb = tonumber(vim.fn.input "Bufnr: ")
  -- local pattern = { "cv.md", "style.css" }
  -- local pattern = vim.fn.input "Pattern: "
  -- local command = { "bash", "./export_to_pdf.sh"}
  -- local command = vim.split(vim.fn.input "Command: ", " ")
  -- attach_to_buffer(bufnb, pattern, command)

end, {})



