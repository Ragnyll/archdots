-- Faster loading for vim
vim.loader.enable()

require("config.lazy")
require("config.color")
require("config.keys")
require("config.opts")

-- Automatically open telescope-file-browser when launching nvim on a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)

    -- If no argument, don't do anything
    if arg == "" then return end

    -- If argument is a directory, take over
    if vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. arg)

      -- open telescope file browser and replace UI
      require("telescope").extensions.file_browser.file_browser({
        path = arg,
        select_buffer = true,
      })
    end
  end,
})


