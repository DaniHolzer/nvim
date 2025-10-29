
-- ~/.dotfiles/nvim/lua/user/plugin_options/gitsigns.lua
-- https://github.com/lewis6991/gitsigns.nvim
--
-- gitsigns is using an old validation method that conflicts with Neovim 0.11's new vim.validate
-- Wrapper temporarily overrides vim.validate before loading gitsigns, then restores it afterward
------------------------------------------------------------------------------
-- Gitsigns Plugin
------------------------------------------------------------------------------
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()

    ---------------------------------------------------------------------------
    -- Workaround because of a error where nvim wants a function but gets table
    -- Temporarily override vim.validate to handle gitsigns' validation with nvim 0.11
    local old_validate = vim.validate
    vim.validate = function(spec, ...)
      -- If called with the new API format (string, value, type, optional)
      if type(spec) == "string" then
        local name, value, expected, optional = spec, ...
        if value == nil and optional then
          return
        end

        local value_type = type(value)
        local valid = false

        if type(expected) == "function" then
          valid = expected(value)
        elseif type(expected) == "string" then
          valid = value_type == expected
        elseif type(expected) == "table" then
          for _, t in ipairs(expected) do
            if value_type == t then
              valid = true
              break
            end
          end
        end

        if not valid then
          error(string.format("validation failed for '%s'", name), 2)
        end
        return
      end

      -- Otherwise use the old API
      return old_validate(spec, ...)
    end
   ---------------------------------------------------------------------------


    local gitsigns = require("gitsigns")

    ---------------------------------------------------------------------------
    --- Settings
    gitsigns.setup({
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = ' ' },
        topdelete    = { text = ' ' },
        changedelete = { text = '▎' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = ' ' },
        topdelete    = { text = ' ' },
        changedelete = { text = '▎' },
      },
      signcolumn           = true,
      numhl                = false,
      linehl               = false,
      word_diff            = false,
      watch_gitdir         = {
        interval     = 1000,
        follow_files = true,
      },
      auto_attach             = true,
      attach_to_untracked     = true,
      current_line_blame      = true,
      current_line_blame_opts = {
        virt_text         = true,
        virt_text_pos     = 'eol',
        delay             = 10,
        ignore_whitespace = false,
        use_focus         = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority    = 6,
      update_debounce  = 100,
      status_formatter = nil,
      max_file_length  = 40000,
      preview_config   = {
        border   = 'single',
        style    = 'minimal',
        relative = 'cursor',
        row      = 0,
        col      = 1,
      },
    })

    -- Restore original vim.validate after gitsigns is loaded
    vim.validate = old_validate
  end,
}
