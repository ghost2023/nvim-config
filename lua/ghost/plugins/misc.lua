return {
  {
    "echasnovski/mini.pairs",
    version = "*",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
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
    "kndndrj/nvim-dbee",
    event = "VeryLazy",
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

      vim.api.nvim_create_user_command("Dbee", function()
        require("dbee").toggle()
      end, { force = true })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      --
      vim.g.db_ui_tmp_query_location = "~/queries"
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  { "akinsho/toggleterm.nvim", version = "*", cmd = "ToggleTerm", config = true },
  {
    "karb94/neoscroll.nvim",
    opts = {
      easing = "quadratic",
      duration_multiplier = 0.8,
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
    config = function()
      vim.bo.formatexpr = ""
      vim.bo.formatprg = "jq"
      vim.g.rest_nvim = {
        _log_level = vim.log.levels.DEBUG,
        request = {
          hooks = {
            encode_url = false,
          },
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vnd.api+json",
        callback = function(ev)
          vim.bo[ev.buf].filetype = "json"
        end,
      })
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      processor = "magick_cli",
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
}
