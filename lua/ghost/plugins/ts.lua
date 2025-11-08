return {
    {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    enabled=false,
    config = function()
      vim.lsp.enable("ts_ls", false)
    end,
  },

  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    config = function()
      require("tsc").setup()
    end,
  },
  { 'dmmulroy/ts-error-translator.nvim', config = function() require('ts-error-translator').setup() end },
}
