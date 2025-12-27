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
      automatic_installation = true,
      ensure_installed = {
        "stylua",
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters

    -- configure null_ls
    null_ls.setup({
      sources = {
        formatting.prettier,
        -- formatting.biome.with({
        --   configurationPath= "~/.config/nvim/biome.json",
        -- }),
        formatting.stylua,
        -- require("none-ls.diagnostics.eslint_d"),
      },
    })

    -- configure format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = augroup })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      pattern = { "*.ts", "*.js", "*.jsx", "*.tsx", "*.json", "*.html", ".css", ".dart" },
      callback = function()
        vim.lsp.buf.format()
        vim.cmd("silent! write")
      end,
    })
  end,
}
