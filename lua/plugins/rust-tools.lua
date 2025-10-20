return {
  "simrat39/rust-tools.nvim",
  requires = {
    {"neovim/nvim-lspconfig"},
    {"williamboman/mason.nvim"}, -- Updated plugin name (instead of nvim-lsp-installer)
    {"nvim-lua/plenary.nvim"},
  },
  config = function()
    local rt = require("rust-tools")

    -- Setup rust-analyzer using vim.lsp.config new API
    -- This avoids deprecated require('lspconfig') usage
    vim.lsp.config.rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
      on_attach = function(_, bufnr)
        -- You can re-enable these mappings if you want
        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    }

    -- Start rust-analyzer LSP server with new API
    vim.lsp.start({ name = "rust_analyzer" })

    -- Setup rust-tools with options as usual
    rt.setup({
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      -- server field is deprecated, setup rust-analyzer above
    })
  end,
}
