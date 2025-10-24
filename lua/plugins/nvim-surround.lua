------------------------------------------------------------------------------
-- Neovim Surround Plugin
-- https://github.com/kylechui/nvim-surround
-- Add/delete/change surrounding pairs and HTML tags
------------------------------------------------------------------------------
return {
  "kylechui/nvim-surround",
  version ="^3.0.0",
  event = "VeryLazy",
  config = function()
    local nvim_surround = require("nvim-surround")

    nvim_surround.setup({
      -- Put configuration in here or let it empty for the default.

      -- Default commands:
      -- ysiw)     = surround word with ()
      -- ys$"      = surround till end of line with ""
      -- ds]       = erase [] around line
      -- dst       = remove HTML tags of the element
      -- cs'"      = change quotes from ' to "
      -- csth1<CR> = change HTML tag to <h1>
      -- dsf       = erase () around actual content
    })

    ------------------------------------------------------------
    -- Key Mappings

    -- Surround word with ():
    vim.keymap.set("n", "((", "ysiw)", { remap = true })
    -- Surround word with {}:
    vim.keymap.set("n", "{{", "ysiw}", { remap = true })
    -- Surround word with []:
    vim.keymap.set("n", "[[", "ysiw]", { remap = true })
    -- Surround word with "":
    vim.keymap.set("n", '""', 'ysiw"', { remap = true })
    -- Surround word with '':
    vim.keymap.set("n", "''", "ysiw'", { remap = true })
    -- Surround word with ``:
    vim.keymap.set("n", "``", "ysiw`", { remap = true })
    -- Surround word with <>:
    vim.keymap.set("n", "<>", "ysiw>", { remap = true })

    -- Surround marked with ():
    vim.keymap.set("v", "((", "S)", { remap = true })
    -- Surround marked with {}:
    vim.keymap.set("v", "{{", "S}", { remap = true })
    -- Surround marked with []:
    vim.keymap.set("v", "[[", "S]", { remap = true })
    -- Surround marked with "":
    vim.keymap.set("v", '""', 'S"', { remap = true })
    -- Surround marked with '':
    vim.keymap.set("v", "''", "S'", { remap = true })
    -- Surround marked with ``:
    vim.keymap.set("v", "``", "S`", { remap = true })
    -- Surround marked with <>:
    vim.keymap.set("v", "<>", "S>", { remap = true })


    -- Surround with tag:
    vim.keymap.set("n", "swt", "ySSt", { remap = true })
    -- Surround marked with tag:
    vim.keymap.set("v", "swt", "St", { remap = true })

end,
}
