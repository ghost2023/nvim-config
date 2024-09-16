return {
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  {
    "moll/vim-bbye",
    event = "VeryLazy",
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
  },

  {
    "kndndrj/nvim-dbee",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
  },
  { "echasnovski/mini.icons", version = false, event = "UIEnter" },
}
