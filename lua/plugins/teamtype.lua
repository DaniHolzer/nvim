------------------------------------------------------------------------------
-- Teamtype Plugin
-- https://github.com/teamtype/teamtype
-- Collaboration Plugin that works diretkly in Nvim
------------------------------------------------------------------------------
return{
  "teamtype/teamtype-nvim",
  keys = {
    { "<leader>ej", "<cmd>TeamtypeJumpToCursor<cr>" },
    { "<leader>ef", "<cmd>TeamtypeFollow<cr>" },
  },
  lazy = false,
}
