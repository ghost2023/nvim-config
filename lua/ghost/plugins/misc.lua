return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  {
    "moll/vim-bbye",
    cmd = { "Bwipeout", "Bdelete" },
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
  },

  {
    "kndndrj/nvim-dbee",
    -- event = "VeryLazy",
    cmd = "Dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        drawer = {
          window_options = {
            winheight = 18,
          },
        },
        editor = {
          window_options = {
            winheight = 18,
          },
        },
      })
    end,
  },
  { "echasnovski/mini.icons", version = false, event = "UIEnter" },
}
