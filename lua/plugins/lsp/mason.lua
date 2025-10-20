-------------------------------------------------------------------------------
-- Mason Plugin
-- https://github.com/williamboman/mason-org/mason.nvim
-- Package manager for LSP servers.
-------------------------------------------------------------------------------
return {
    -- import mason-lspconfig.nvim
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            'angularls',                       -- Angular language server.
            'ansiblels',                       -- Ansible language server.
            'arduino_language_server',         -- Arduino language server.
            'azure_pipelines_ls',              -- Azure Pipelines language server.
            'bashls',                          -- Bash language server.
            'clangd',                          -- C, C++, Objective-C language server.
            'cmake',                           -- CMake language server.
            --'csharp_ls',                       -- C# language server.
            'cssls',                           -- CSS language server.
            'cucumber_language_server',        -- Cucumber language server.
            'denols',                          -- Deno language server.
            'diagnosticls',                    -- Diagnostic Node.js and Composer server.
            'docker_compose_language_service', -- Docker Compose Language Server.
            'dockerls',                        -- Docker language server.
            'emmet_ls',                        -- Emmet HTML completion server.  -- emmet-language-server
            'gradle_ls',                       -- Gradle language server.
            'grammarly',                       -- Grammarly spell checker server.
            'graphql',                         -- GraphQL language server.
            --'hls',                             -- Haskell language server.
            'html',                            -- HTML language server.
            --'htmx',                            -- HTMX language server.
            'intelephense',                    -- PHP language server.
            'jdtls',                           -- Java language server.
            'jsonls',                          -- JSON language server.
            'kotlin_language_server',          -- Kotlin language server.
            'lemminx',                         -- XML language server.
            'ltex',                            -- LaTeX language server.
            'lua_ls',                          -- Lua language server.
            --'autotools_ls',                    -- Make language server.
            'marksman',                        -- Markdown language server.
            'matlab_ls',                       -- MATLAB language server.
            --'pest_ls',                         -- Pest PHP testing framework language server.
            'powershell_es',                   -- PowerShell language server.
            'prismals',                        -- Prisma language server.
            'pyright',                         -- Python language server.
            --'r_language_server',               -- R language server.
            --'ruby_ls',                         -- Ruby language server.
            'rust_analyzer', -- Rust language server.
            --'salt_ls',                         -- SaltStack language server.
            'spectral',      -- Spectral OpenAPI linter.
            'sqlls',         -- SQL language server.
            'svelte',        -- Svelte language server.
            'tailwindcss',   -- Tailwind CSS language server.
            'taplo',         -- TOML language server.
            'terraformls',   -- Terraform language server.
            'tsserver',      -- JavaScript/TypeScript language server.
            'volar',         -- Vue language server.
            'yamlls',        -- YAML language server.
            --'editorconfig-checker',            -- EditorConfig checker.
            --'nginx_language_server',           -- NGINX language server.
            'vimls', -- Vim language server.
            -- 'twigcs',                          -- Twig language server.
            -- 'pint',
            -- 'php-debug-adapter',
            -- 'phpstan',                         -- PHPStan language server.
          },
          automatic_enable = false,
        },
        dependencies = {
          -- import mason
          { "mason-org/mason.nvim",
            opts = {
              ui = {
                check_outdated_packages_on_open = true, -- Check for new versions when opening Mason.
                border                          = 'nil', -- Border style of the Mason floating window.
                width                           = 0.8, -- Width in % of the Mason floating window.
                height                          = 0.9, -- Height in % of the Mason floating window.
                icons                           = {
                  package_installed   = '✓', -- Icon for installed packages.
                  package_pending     = '➜', -- Icon for pending packages.
                  package_uninstalled = '✗', -- Icon for uninstalled packages.
                }
              }
            }
          },
          "neovim/nvim-lspconfig",
        },
    }


    -------------------------------------------------------------------------------
    -- Formatters

    -- mason_tool_installer.setup({
    --   ensure_installed = {
    --     "prettier", -- prettier formatter
    --     "stylua", -- lua formatter
    --     "isort", -- python formatter
    --     "black", -- python formatter
    --     "pylint",
    --     "eslint_d",
    --   },
    -- })
}
