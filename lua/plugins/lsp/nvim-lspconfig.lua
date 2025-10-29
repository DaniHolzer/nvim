-------------------------------------------------------------------------------
-- LSP Plugin
-- https://github.com/neovim/nvim-lspconfig
-- Plugin to use LSP servers.
-------------------------------------------------------------------------------
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy-load on buffer read/new file events
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",                -- LSP source for nvim-cmp completion
    { "antosha417/nvim-lsp-file-operations", config = true }, -- File operation LSP enhancement
    { "folke/neodev.nvim", opts = {} },    -- Lua development for Neovim
    "artemave/workspace-diagnostics.nvim", -- Custom diagnostics workspace integration
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Configure diagnostic UI globally
    vim.diagnostic.config({
      virtual_text = true,  -- Show inline virtual text for diagnostics
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = " ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      underline = true,           -- Underline diagnostic text
      update_in_insert = false,   -- Do not update diagnostics while inserting
      severity_sort = true,       -- Show diagnostics sorted by severity
    })

    -- Setup LspAttach autocmd for buffer local keymaps and LSP actions
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        --- Navigation ---
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        --- Actions ---
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        --- Diagnostics ---
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

        --- Misc ---
        opts.desc = "Show documentation for cursor word"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Enhance LSP capabilities with nvim-cmp for autocompletion compatibility
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Common on_attach for most LSP clients: populates workspace diagnostics
    local function default_on_attach(client, bufnr)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end

    ----------------------------------------------------------------------------
    -- LANGUAGE SERVER CONFIGURATIONS
    ----------------------------------------------------------------------------

    -- Tailwind CSS server with experimental class regex config
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { '(["\'`][^"\'`]*.*?["\'`])'},
            },
          },
        },
      },
    })
    vim.lsp.enable("tailwindcss")

    -- Svelte with special notification on write for TypeScript and JavaScript
    vim.lsp.config("svelte", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })
    vim.lsp.enable("svelte")

    -- GraphQL language server
    vim.lsp.config("graphql", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })
    vim.lsp.enable("graphql")

    -- Emmet for markup and stylesheets
    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })
    vim.lsp.enable("emmet_ls")

    -- Lua language server with custom cmd and settings
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    -- PHP with blade support and file size limit
    vim.lsp.config("intelephense", {
      capabilities = capabilities,
      on_attach = default_on_attach,
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
    vim.lsp.enable("intelephense")

    -- CSS, SCSS, Less with linting config
    vim.lsp.config("cssls", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "css", "scss", "less", "sass" },
      settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
      },
    })
    vim.lsp.enable("cssls")

    -- Ansible support
    vim.lsp.config("ansiblels", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "yaml", "yml", "ansible" },
    })
    vim.lsp.enable("ansiblels")

    -- YAML language server
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "yaml", "yml" },
    })
    vim.lsp.enable("yamlls")

    -- Bash-like shell scripts
    vim.lsp.config("bashls", {
      capabilities = capabilities,
      on_attach = default_on_attach,
      filetypes = { "sh", "bash", "zsh", "fish", "dash", "ksh" },
    })
    vim.lsp.enable("bashls")

    -- ESLint with autofix on save
    vim.lsp.config("eslint", {
      settings = { packageManager = "yarn" },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })
    vim.lsp.enable("eslint")
  end,
}
