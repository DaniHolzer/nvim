-------------------------------------------------------------------------------
-- Mason Plugin
-- https://github.com/williamboman/mason-org/mason.nvim
-- Package manager for LSP servers.
-------------------------------------------------------------------------------
return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          check_outdated_packages_on_open = true, -- Check for new versions when opening Mason.
          border                          = 'none', -- Border style of the Mason floating window.
          width                           = 0.8, -- Width in % of the Mason floating window.
          height                          = 0.9, -- Height in % of the Mason floating window.
          icons                           = {
            package_installed   = '✓', -- Icon for installed packages.
            package_pending     = '➜', -- Icon for pending packages.
            package_uninstalled = '✗', -- Icon for uninstalled packages.
          },
        },
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "angularls", "ansiblels", "arduino_language_server", "azure_pipelines_ls",
        "bashls", "clangd", "cmake", "cssls", "cucumber_language_server",
        "denols", "diagnosticls", "docker_compose_language_service", "dockerls",
        "emmet_ls", "gradle_ls", "grammarly", "graphql", "html", "intelephense",
        "jdtls", "jsonls", "kotlin_language_server", "lemminx", "ltex", "lua_ls",
        "marksman", "matlab_ls", "powershell_es", "prismals", "pyright",
        "rust_analyzer", "spectral", "sqlls", "svelte", "tailwindcss",
        "taplo", "terraformls", "tsserver", "volar", "yamlls", "vimls",
      },
      automatic_installation = true,
      automatic_enable = true, -- new API: enables installed servers automatically
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}
