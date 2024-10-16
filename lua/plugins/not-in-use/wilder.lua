-------------------------------------------------------------------------------

-- use {
--   'gelguy/wilder.nvim',
--   config = function()
--     require('user.plugin_options.wilder')
--   end,
-- }





------------------------------------------------------------------------------
-- Wilder Plugin

-- Wilder (command line auto complete style)
-- https://github.com/gelguy/wilder.nvim
------------------------------------------------------------------------------
return{
  'gelguy/wilder.nvim',
  config = function()
    local wilder = require('wilder')

wilder.setup({
  modes = {
    ':',
    '/',
    '?',
  },
})

wilder.set_option('renderer', wilder.popupmenu_renderer({
  -- Set up menu highlighting:
  highlighter = wilder.basic_highlighter(),
  highlights = {
    accent = wilder.make_hl(
      'WilderAccent',
      'Pmenu',
      {
        {a = 1},
        {a = 1},
        {foreground = '#569CD6'}
      }
    ),
  },
  -- Use dev icons in pop up:
  left = {
    ' ',
    wilder.popupmenu_devicons()
  },
  -- Activate scrollbar:
  right = {
    ' ',
    wilder.popupmenu_scrollbar()
  },
  -- Set max width for pop up:
  max_width = '100%',
  -- Set max height for pop up:
  max_height = '50%',
  -- Sorting is ascending:
  reverse = 0,
}))
  end,
}
