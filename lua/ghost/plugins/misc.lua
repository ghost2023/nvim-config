return {
  {
    "tzachar/highlight-undo.nvim",
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  {
    event = "VeryLazy",
    "moll/vim-bbye",
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "editorconfig/editorconfig-vim",
  },

  {
    "kndndrj/nvim-dbee",
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
      -- Configuration object.
      ---@class Config
      ---@field default_connection? string
      ---@field extra_helpers? table<string, table<string, string>>
      ---@field float_options? table<string, any>
      ---@field drawer? drawer_config
      ---@field editor? editor_config
      ---@field result? result_config
      ---@field call_log? call_log_config

      ---@class Candy
      ---@field icon string
      ---@field icon_highlight string
      ---@field text_highlight string

      ---Keymap options.
      ---@alias key_mapping { key: string, mode: string, opts: table, action: string|fun() }

      ---@divider -

      ---Configuration for result UI tile.
      ---@alias result_config { mappings: key_mapping[], page_size: integer,  window_options: table<string, any>, buffer_options: table<string, any> }

      ---Configuration for editor UI tile.
      ---@alias editor_config { directory: string, mappings: key_mapping[], window_options: table<string, any>, buffer_options: table<string, any> }

      ---Configuration for call log UI tile.
      ---@alias call_log_config { mappings: key_mapping[], disable_candies: boolean, candies: table<string, Candy>, window_options: table<string, any>, buffer_options: table<string, any> }

      ---Configuration for drawer UI tile.
      ---@alias drawer_config { disable_candies: boolean, candies: table<string, Candy>, mappings: key_mapping[], disable_help: boolean, window_options: table<string, any>, buffer_options: table<string, any> }

      ---@divider -

      -- DOCGEN_START
      ---Default configuration.
      ---To see defaults, run :lua= require"dbee.config".default
      ---@type Config config
      local config = {
        result = {
          page_size = 14,
        },
      }
      require("dbee").setup()
    end,
  },
}
