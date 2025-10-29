------------------------------------------------------------------------------
-- mannydark plugin
-- https://github.com/MannyFay/mannydark.nvim
-- A very dark color scheme
------------------------------------------------------------------------------
return {
   'MannyFay/mannydark.nvim',
    config = function()
      vim.cmd([[
        try
          colorscheme mannydark
        catch /^Vim\%((\a\+)\)\=:E185/
          colorscheme default
          set background=dark
        endtry
      ]])
    end,
}
