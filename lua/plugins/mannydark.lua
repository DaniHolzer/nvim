------------------------------------------------------------------------------
-- mannydark plugin
-- https://github.com/MannyFay/mannydark.nvim
-- A very dark color scheme
------------------------------------------------------------------------------
return {
  'MannyFay/mannydark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local colorscheme = require('mannydark')

    colorscheme.setup({ })

    vim.cmd.colorscheme('mannydark')
  end,}
