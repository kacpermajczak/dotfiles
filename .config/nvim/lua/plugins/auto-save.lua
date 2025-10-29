return {
  "pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = function()
          return "" -- Silent message
        end,
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      -- Optional: configure specific filetypes
      -- condition = function(buf)
      --   local fn = vim.fn
      --   local utils = require("auto-save.utils.data")
      --
      --   -- don't autosave for certain filetypes
      --   if utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
      --     return true
      --   end
      --   return false
      -- end,
    })
  end,
}
