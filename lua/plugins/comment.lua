------------------------------------------------------------------------------
-- Comment Plugin

-- ~/.dotfiles/nvim/lua/user/plugin_options/comment.lua

-- https://github.com/numtostr/comment.nvim
------------------------------------------------------------------------------
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependensies = {
	  "JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
	  -- import comment plugin safely
	  local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring")

    ts_context_commentstring.setup ({
      enable_autocmd = false,
    })

	  comment.setup({
      padding = true,         -- Add a space after and before the comment symbol.
      sticky  = true,         -- Stay with cursor on it's position if commenting stuff.
      ignore  = '^%s*$',      -- Ignore empty lines while (un)comment.
      -- Mappings (normal mode):
      toggler = {
        line  = '<Leader>/',  -- Command for line-comment.
        block = '<Nop>'       -- Command for block-comment (<Nop> = no command).
      },
      -- Operator-pending mappings (normal and visual mode):
      opleader = {
        line  = '<Leader>/',  -- Command for Line-comment.
        block = '<Leader>/s', -- Command for block-comment.
      },
      -- Extra mappings:
      extra = {
        above = '<Nop>',      -- Add comment on the line above (<Nop> = no command).
        below = '<Nop>',      -- Add comment on the line below (<Nop> = no command).
        eol   = '<Nop>',      -- Add comment at the end of line (<Nop> = no command).
      },
      -- Enable keybindings (if 'false', it won't create any mappings!):
      mappings = {
        basic = true,         -- Enable operator-pending mappings.
        extra = false,        -- Enable extra mappings.
      },
      -- pre_hook = nil,      -- Function to call before (un)comment.
      -- for commenting tsx, jsx, svelte, html files (make commentstring work with comment plugin)
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      post_hook = function()
      end,
    })
	end,
}
