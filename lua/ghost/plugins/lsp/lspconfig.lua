return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    vim.lsp.inlay_hint.enable()

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local ensure_installed = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      -- "eslint",
      "clangd",
      "lua_ls",
      "gopls",
      "emmet_language_server",
      "prismals",
      "pyright",
    }

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = ensure_installed,
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    for _, value in pairs(ensure_installed) do
      if value ~= "emmet_language_server" then
        lspconfig[value].setup({
          capabilities = capabilities,
        })
      end
    end

    -- configure svelte server
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", {
                uri = ctx.file,
                changes = {
                  {
                    text = table.concat(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false), "\n"),
                  },
                },
              })
            end
          end,
          group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
        })
      end,
    })

    -- configure rust_analyzer server
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importEnforceGranularity = true,
            importPrefix = "crate",
          },
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          inlayHints = { locationLinks = false },
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },
        },
      },
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local _border = "single"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = _border,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = _border,
    })

    vim.diagnostic.config({
      float = { border = _border },
    })

    local util = require("lspconfig/util")

    -- configure emmet language server
    lspconfig["emmet_language_server"].setup({
      capabilities = capabilities,
      filetypes = { "html", "css", "sass", "scss", "less", "svelte" },
      showSuggestionsAsSnippets = true,
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
