-------------------------------------------------------------------------------
-- Treesitter-Auto-Tag Plugin
-- https://github.com/windwp/nvim-ts-autotag
-- Use treesitter to auto-close and auto-rename html tags.
-------------------------------------------------------------------------------
return {
  "windwp/nvim-ts-autotag",
  config = function()
    local ts_autotag = require('nvim-ts-autotag')

    ts_autotag.setup({
      enable_close = true,          -- Auto close tags
      enable_rename = true,         -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </>
      -- You can also override per filetype:
      -- per_filetype = {
      --   html = { enable_close = false },
      -- }
    })
  end,
}
