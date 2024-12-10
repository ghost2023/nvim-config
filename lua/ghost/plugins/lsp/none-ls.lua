return {
  "nvimtools/none-ls.nvim",
  -- lazy = true,
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    mason_null_ls.setup({
      ensure_installed = {
        "prettierd",
        "stylua",
        "black",
        "eslint_d",
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters

    -- configure null_ls
    null_ls.setup({
      sources = {
        formatting.prettierd.with({
          extra_filetypes = { "svelte" },
        }),
        formatting.stylua,
        formatting.isort,
        formatting.black,
        -- require("none-ls.diagnostics.eslint_d").with({
        --   root_dir = lspconfig.util.root_pattern(".eslintrc"),
        -- }),
        require("none-ls.formatting.jq"),
      },
    })

    -- configure format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = augroup })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        local clients = vim.lsp.get_clients({ name = "ts_ls" })
        for _, client in ipairs(clients) do
          if client.name == "ts_ls" then
            vim.lsp.buf.execute_command({
              command = "_typescript.organizeImports",
              arguments = { vim.fn.expand("%:p") },
            })
          end
        end
        vim.lsp.buf.format()
        vim.cmd("silent! write")
      end,
    })
  end,
}
