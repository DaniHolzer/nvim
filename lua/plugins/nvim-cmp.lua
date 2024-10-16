-------------------------------------------------------------------------------
-- Nvim CMP (Completion Management Plugin) Plugin
-- https://github.com/hrsh7th/nvim-cmp
-------------------------------------------------------------------------------
return {

	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
	"hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()

	local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

require('luasnip/loaders/from_vscode').lazy_load()              -- Load snippet engine from VSCode with Friendly Snippets plugin.


-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
  enabled = true,                                               -- Enable CMP plugin.

  -- Completion update behavior (lower values are faster but take more CPU power):
  performance = {
    debounce                = 100,                              -- (milliseconds) Time to display completion menu after stop typing.
    throttle                = 100,                              -- (milliseconds) Waiting time after user input to update completion entries.
    fetching_timeout        = 100,                              -- (milliseconds) Time to wait till completion menu is displayed.
    confirm_resolve_timeout = 100,                              -- (milliseconds) Time to wait till to display additional information about completion entry.
    async_budget            = 500,                              -- (milliseconds) UI respondiveness budget by handling background tasks.
    max_view_entries        = 20,                               -- Number of entries to display in completion menu.
  },

  -- Preselection behavior:
  preselect = cmp.PreselectMode.None,                           -- Disable preselect (Item = preselect item that the source specified).

  -- Key bindings for completion:
  mapping = {
    ['<C-Tab']  = cmp.mapping.confirm({ select = true }),       -- Confirm auto complete selection.
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),               -- To previous list item.
    ['<Tab>']   = cmp.mapping.select_next_item(),               -- To next list item.
    ['<C-q>']   = cmp.mapping.abort(),                          -- Quit suggestion pop-up.
    ['<C-j>']   = cmp.mapping.scroll_docs(4),                   -- Scroll down in docs.
    ['<C-k>']   = cmp.mapping.scroll_docs(-4),                  -- Scroll up in docs.
    ['<C-c>']   = cmp.mapping.complete(),                       -- Show completion suggestions.
  },

  -- Load snippet engine to use with CMP:
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)                             -- Activate LuaSnip expansion.
    end,
  },

  -- Completion behavior:
  completion = {
    completeopt = 'menu,menuone,noselect',                   -- Enable completion pop-up, complete if there is only one, don't jump in menu.
    keyword_length = 1,                                         -- Minimal number of characters to trigger completion.
  },

  -- Appearance:
  view = {
    docs = {
      auto_open = true,                                         -- 'true': Show documentatiion if selecting an item.
    },
    entries = 'custom',                                         -- completion menu above command line (custom, wildmenu, native ('cmp.setup.cmdline' does not work with 'native').
  },

  -- Menu style:
  window = {
    -- Completion window:
    completion = {
      border       = { ' ', '', ' ', ' ', ' ', '', ' ', ' ' },  -- One space on the left and the right in completion window.
      scrolloff    = 3,                                         -- Minimal number of lines to keep above and below cursor.
      col_offset   = 0,                                         -- Offset from completion menu to cursor.
      side_padding = 0,                                         -- Padding on left and right of completion menu.
      scrollbar    = true,                                      -- 'true': Show scrollbar in completion menu.
    },
    -- Documentation window:
    documentation = {
      border     = { ' ', '', ' ', ' ', ' ', '', ' ', ' ' },    -- One space on the left and the right in documentation window.
      scrolloff  = 3,                                           -- Minimal number of lines to keep above and below cursor.
      max_width  = math.floor(vim.o.columns * 0.9),             -- Max width of documentation window.
      max_height = math.floor(vim.o.lines * 0.3),               -- Max height of documentation window.
    },
  },

  -- Icon set in completion menu:
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 1000,
      ellipsis_char = '...',
    }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip'  },
    { name = 'buffer'   },
    { name = 'path'     },
    { name = 'cmp_breadcrumb' },
  }),

})

-- Genghis direction autocompletion requires this for CMP after CMP setup:
cmp.setup.filetype('DressingInput', {
  sources = cmp.config.sources { {name = 'omni'} },
})

end,
}
