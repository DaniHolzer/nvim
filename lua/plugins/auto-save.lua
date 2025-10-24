-------------------------------------------------------------------------------
-- Auto-Save Plugin
-- https://github.com/Pocco81/auto-save.nvim
-------------------------------------------------------------------------------

return {
  "pocco81/auto-save.nvim",
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  config = function()
	  local autosave = require("auto-save")

    autosave.setup({
       enabled           = true,                              -- Enable plugin.
       execution_message = {
        message = function()
          return ("Saved at " .. vim.fn.strftime("%H:%M:%S")) -- Message to print on save.
        end,
        dim               = 0.18,                             -- Dim the color of `message`.
        cleaning_interval = 1250,                             -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },

      -- Function that determines whether to save the current buffer or not (true: if buffer is ok to be saved. false: if it's not ok to be saved).
      condition = function(buf)
        local fn    = vim.fn
        local utils = require("auto-save.utils.data")

        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {"harpoon"}) then
          return true
        end

        return false
      end,

      -- Writing behavior:
      write_all_buffers = true,       -- Write all buffers when the current one meets `condition`.
      debounce_delay    = 135,        -- Saves the file at most every `debounce_delay` milliseconds.
      callbacks = {                   -- Functions to be executed at different intervals.
        enabling              = nil,  -- Ran when enabling auto-save.
        disabling             = nil,  -- Ran when disabling auto-save.
        before_asserting_save = nil,  -- Ran before checking `condition`.
        before_saving         = nil,  -- Ran before doing the actual save.
        after_saving          = nil,  -- Ran after doing the actual save.
      },
    })
  end,
}
