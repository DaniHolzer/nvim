------------------------------------------------------------------------------
-- Neovim Lastplace Plugin
-- https://github.com/ethanholz/nvim-lastplace
-- Restore your cursor to the last edit position when reopening files
------------------------------------------------------------------------------
return{
    "ethanholz/nvim-lastplace",
    config = function()
      local lastplace = require("nvim-lastplace")
      lastplace.setup ({
        lastplace_ignore_buftype = {
          'quickfix',
          'nofile',
          'help'
        },
        lastplace_ignore_filetype = {
          'gitcommit',
          'gitrebase',
          'svn',
          'hgcommit'
        },
        lastplace_open_folds = true
      })
    end,
}
