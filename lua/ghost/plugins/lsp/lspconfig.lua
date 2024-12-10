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

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local ensure_installed = {
      "phpactor",
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
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

    require("mason-lspconfig").setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
          capabilities,
        })
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      ["rust_analyzer"] = function()
        -- configure rust_analyzer server
        lspconfig["rust_analyzer"].setup({
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              inlayHints = { locationLinks = false },
              diagnostics = {
                enable = true,
              },
            },
          },
        })
      end,
      -- ["denols"] = function()
      --   lspconfig["denols"].setup({
      --     root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      --     init_options = {
      --       lint = true,
      --       unstable = true,
      --       suggest = {
      --         imports = {
      --           hosts = {
      --             ["https://deno.land"] = true,
      --             ["https://cdn.nest.land"] = true,
      --             ["https://crux.land"] = true,
      --           },
      --         },
      --       },
      --     },
      --     on_attach = function()
      --       local active_clients = vim.lsp.get_clients()
      --       for _, client in pairs(active_clients) do
      --         -- stop tsserver if denols is already active
      --         if client.name == "tsserver" then
      --           client.stop()
      --         end
      --       end
      --     end,
      --   })
      -- end,
      ["eslint"] = function()
        lspconfig.eslint.setup({
          -- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
          root_dir = lspconfig.util.root_pattern(
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.yaml",
            ".eslintrc.yml",
            ".eslintrc.json",
            "eslint.config.js"
          -- Disabled to prevent "No ESLint configuration found" exceptions
          -- 'package.json',
          ),
        })
      end,
      ["svelte"] = function()
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
                        text = table.concat(
                          vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false),
                          "\n"
                        ),
                      },
                    },
                  })
                end
              end,
              group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
            })
          end,
        })
      end,
      ["csharp_ls"] = function()
        -- configure rust_analyzer server
        lspconfig["csharp_ls"].setup({
          root_dir = function(startpath)
            return lspconfig.util.root_pattern("*.sln")(startpath)
                or lspconfig.util.root_pattern("*.csproj")(startpath)
                or lspconfig.util.root_pattern("*.fsproj")(startpath)
                or lspconfig.util.root_pattern(".git")(startpath)
          end,
          capabilities = capabilities,
        })
      end,

      ["emmet_language_server"] = function()
        -- configure emmet language server
        lspconfig["emmet_language_server"].setup({
          capabilities = capabilities,
          filetypes = { "html", "css", "sass", "scss", "less", "svelte" },
          showSuggestionsAsSnippets = true,
        })
      end,

      -- configure lua server (with special settings)
      ["lua_ls"] = function()
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
  end,
}
