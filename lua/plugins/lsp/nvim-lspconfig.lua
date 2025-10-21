-------------------------------------------------------------------------------
-- LSP Plugin
-- https://github.com/neovim/nvim-lspconfig
-- Plugin to use LSP servers.
-------------------------------------------------------------------------------
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "maso-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "antosha417/nvim-lsp-file-operations",
    },
    config = function()
      ------------------------------------------------------------
      -- 🧩 Diagnostic signs
      ------------------------------------------------------------
      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = " ",
        Info  = " ",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded" },
      })

      ------------------------------------------------------------
      -- 🧠 Global LSP defaults
      ------------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp.default_capabilities(capabilities)
      end

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        local keymap = vim.keymap.set
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "gi", vim.lsp.buf.implementation, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      ------------------------------------------------------------
      -- 🏗️ Default config for all servers
      ------------------------------------------------------------
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      ------------------------------------------------------------
      -- 🧩 Per-server configurations
      ------------------------------------------------------------

      -- Svelte
      vim.lsp.config("svelte", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              -- Use ctx.match instead of ctx.file
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
      })

      -- GraphQL
      vim.lsp.config("graphql", {
        capabilities = capabilities,
        filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      })

      -- Emmet
      vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
        },
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            telemetry = { enable = false },
            completion = { callSnippet = "Replace" },
          },
        },
      })

      -- TypeScript
      vim.lsp.config("tsserver", {
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
      })

      -- Intelephense
      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Disable built-in formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        filetypes = { "php", "blade" },
        settings = {
          intelephense = {
            filetypes = { "php", "blade" },
            files = {
              associations = { "*.php", "*.blade.php" },
              maxSize = 5000000,
            },
          },
        },
      })
      require("plugins.lspconfig").setup()
    end,
  },
}

