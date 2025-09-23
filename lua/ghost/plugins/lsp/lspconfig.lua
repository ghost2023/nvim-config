return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local ensure_installed = {
      -- "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "clangd",
      "lua_ls",
      "gopls",
      "emmet_ls",
      "prismals",
      "pyright",
    }

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = ensure_installed,
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed

      automatic_enable = {
        exclude = {
          "rust_analyzer",
        },
      },
    })

    vim.lsp.config("emmet_ls", {
      filetypes = { "html", "css", "sass", "scss", "less" },
      showSuggestionsAsSnippets = false,
    })

    vim.lsp.enable("eslint",false)


    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      float = { border = "single" },
    })


    require("lspconfig").ts_ls.setup({
      cmd = { "tsgo", "--lsp", "--stdio" },
    })

  end,
}
