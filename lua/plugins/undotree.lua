-------------------------------------------------------------------------------
-- Undotree Plugin
-- https://github.com/mbbill/undotree
-- Visualizes the undo history
-------------------------------------------------------------------------------
return{
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>utt', vim.cmd.UndotreeToggle)

      -- if has("persistent_undo")
      --    let target_path = expand('~/.undodir')

      --     " create the directory and any parent directories
      --     " if the location does not exist.
      --     if !isdirectory(target_path)
      --         call mkdir(target_path, "p", 0700)
      --     endif

      --     let &undodir=target_path
      --     set undofile
      -- endif
    end,
}
