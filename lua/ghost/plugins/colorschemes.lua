return {
  {
    "w0ng/vim-hybrid",
    config = function()
      vim.cmd("colorscheme hybrid")
    end,
    lazy = false,
    priority = 1000,
  },
  {
    "marko-cerovac/material.nvim",
    event = "VeryLazy",
  },
  {
    event = "VeryLazy",
    "Mofiqul/vscode.nvim",
  },
  {
    event = "VeryLazy",
    "catppuccin/nvim",
    as = "catppuccin",
  },
  {
    event = "VeryLazy",
    "nanotech/jellybeans.vim",
  },
  {
    event = "VeryLazy",
    "folke/tokyonight.nvim",
  },
  {
    event = "VeryLazy",
    "rose-pine/neovim",
  },
  {
    event = "VeryLazy",
    "tiagovla/tokyodark.nvim",
  },
  {
    event = "VeryLazy",
    "projekt0n/github-nvim-theme",
  },
  {
    event = "VeryLazy",
    "rebelot/kanagawa.nvim",
  },
  {
    event = "VeryLazy",
    "olimorris/onedarkpro.nvim",
  },
}
