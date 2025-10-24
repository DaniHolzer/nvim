-------------------------------------------------------------------------------
-- Nvim CMP (Completion Management Plugin) Plugin
-- https://github.com/hrsh7th/nvim-cmp
-- A completion engine plugin for neovim written in Lua
-------------------------------------------------------------------------------
return {
  "hrsh7th/nvim-cmp",
  event = {"InsertEnter", "CmdlineEnter"},
  dependencies = {
     "hrsh7th/cmp-buffer",                   -- Completion source for text in buffer.
    "hrsh7th/cmp-path",                     -- Completion source for file system paths.
    "hrsh7th/cmp-cmdline",                  -- Completion source for text in command line.
    "hrsh7th/cmp-nvim-lsp",                 -- Completion source for built-in LSP.
    "hrsh7th/cmp-nvim-lsp-signature-help",  -- CMP source to display function signatures with parameter explanation.
    "hrsh7th/cmp-nvim-lua",                 -- CMP source for Neovim Lua API.
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",  -- Required for autocompletion
    -- "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",      -- VS-Code like pictograms.
  },
  config = function()

    local cmp     = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"]   = cmp.mapping.select_next_item(),
        ["<C-q>"]   = cmp.mapping.abort(),
        ["<C-j>"]   = cmp.mapping.scroll_docs(4),
        ["<C-k>"]   = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-n>"]   = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-p>"]   = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
        }),
      },
    })

    -- Cmdline completion
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end,
}
