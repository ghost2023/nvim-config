return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
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

      vim.api.nvim_create_user_command("Dbee", function()
        vim.api.nvim_command("tabnew")
        require("dbee").toggle()
      end, { force = true })
    end,
  },
  { "echasnovski/mini.icons", version = false, event = "UIEnter" },
  { "nvchad/volt",            lazy = true },
  {
    "nvchad/minty",
    cmd = { "MintyHue", "MintyShade" },
    config = function()
      vim.api.nvim_create_user_command("MintyHue", function()
        require("minty.huefy").open()
      end, {})

      vim.api.nvim_create_user_command("MintyShade", function()
        require("minty.shades").open()
      end, {})
    end,
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("flutter-tools").setup({
        -- (uncomment below line for windows only)
        -- flutter_path = "home/flutter/bin/flutter.bat",

        debugger = {
          -- make these two params true to enable debug mode
          enabled = false,
          run_via_dap = false,
          register_configurations = function(_)
            require("dap").adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" },
            }

            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = "home/flutter/bin/cache/dart-sdk/",
                flutterSdkPath = "home/flutter",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }
            -- uncomment below line if you've launch.json file already in your vscode setup
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        dev_log = {
          -- toggle it when you run without DAP
          enabled = false,
          open_cmd = "tabedit",
        },
      })
      require("telescope").load_extension("flutter")
    end,
  },
  -- for dart syntax hightling
  {
    "dart-lang/dart-vim-plugin",
  },
  { "ThePrimeagen/vim-be-good",             cmd = "VimBeGood" },
  {
    "https://github.com/szw/vim-maximizer",
    cmd = "MaximizerToggle",
  },
  { "ColinKennedy/cursor-text-objects.nvim" },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = {
      {
        "echasnovski/mini.icons",
        opts = {},
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
}
