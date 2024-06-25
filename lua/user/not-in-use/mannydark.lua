------------------------------------------------------------------------------
-- mannydark plugin

-- https://github.com/MannyFay/mannydark.nvim
------------------------------------------------------------------------------

return {
   'MannyFay/mannydark.nvim',

    vim.cmd[[
        try
      colorscheme mannydark
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
    endtry
]],
}
