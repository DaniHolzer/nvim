-------------------------------------------------------------------------------
-- Nvim Colorizer Plugin
-- https://github.com/norcalli/nvim-colorizer.lua
-- Color highlighter
-------------------------------------------------------------------------------
return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    -- loading termguicolors for colorizer plugin (must be set before colorizer.setup)
    vim.opt.termguicolors = true

    local colorizer = require("colorizer")
    colorizer.setup(
        { '*'},               -- Enable highlighting in all file types:
        { css = true; }       -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    )
    vim.cmd([[
      augroup Colorizer
        autocmd!
        autocmd BufEnter * ColorizerAttachToBuffer
      augroup END
    ]])
end,
}
