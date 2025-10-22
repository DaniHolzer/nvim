-------------------------------------------------------------------------------
-- Nvim CMP (Completion Management Plugin) Plugin
-- https://github.com/hrsh7th/nvim-cmp
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

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Tab>"] = cmp.mapping.confirm({ select = true }),
        -- ["<Leader>es"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ select = false}), -- previous suggestion
        ["<Tab>"]   = cmp.mapping.select_next_item({ select = false }), -- next suggestion
        ["<C-q>"] = cmp.mapping.abort(), -- close completion window
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-c>"] = cmp.mapping.complete(), -- show completion suggestions
        --["<C-e>"] = function() require("luasnip").expand() end,
        ["<C-n>"] = function() require("luasnip").jump( 1) end,
        ["<C-p>"] = function() require("luasnip").jump( -1) end,
        -- ["<C-e>"] = nil, -- Unmap <C-e> in nvim-cmp
      }),

      -- Sources for autocompletion:
      sources = cmp.config.sources({
        { name = "nvim_lsp"},
        { name = "luasnip" }, -- Snippets engine.
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 1000,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
