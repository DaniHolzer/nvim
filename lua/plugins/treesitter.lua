-------------------------------------------------------------------------------
-- Treesitter Plugin
-- https://github.com/nvim-treesitter/nvim-treesitter
-- Automates the installation and management of language parsers.
-- Uses the "main" branch (the old "master" branch does not support Nvim 0.12).
-- Requires the tree-sitter CLI: cargo install --locked tree-sitter-cli
-------------------------------------------------------------------------------
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- Does not support lazy-loading
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local treesitter = require("nvim-treesitter")

    -- Parsers that are always installed:
    treesitter.install({
      "bash", "css", "dockerfile", "html", "javascript", "json", "lua",
      "markdown", "markdown_inline", "php", "scss", "tsx", "typescript",
      "vim", "vimdoc", "yaml",
    })

    -- Enable highlighting and indentation for a buffer:
    local function start(buf)
      if pcall(vim.treesitter.start, buf) then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    -- Start treesitter on every filetype, install missing parsers on the fly:
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", {}),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then return end
        if vim.list_contains(treesitter.get_installed(), lang) then
          start(args.buf)
        elseif vim.list_contains(treesitter.get_available(), lang) then
          treesitter.install(lang):await(function()
            if vim.api.nvim_buf_is_valid(args.buf) then start(args.buf) end
          end)
        end
      end,
    })

    require("ts_context_commentstring").setup({})
    vim.g.skip_ts_context_commentstring_module = true
  end,
}
