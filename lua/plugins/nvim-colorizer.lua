-------------------------------------------------------------------------------
-- Nvim Colorizer Plugin
-- https://github.com/catgoose/nvim-colorizer.lua
-- Color highlighter
-------------------------------------------------------------------------------
return {
  "catgoose/nvim-colorizer.lua",
  config = function()
    -- loading termguicolors for colorizer plugin (must be set before colorizer.setup)
    vim.opt.termguicolors = true

    local colorizer = require("colorizer")
    colorizer.setup({
      filetypes = { "*" },                  -- Enable highlighting in all file types
      options = { parsers = { css = true } }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    })
end,
}
